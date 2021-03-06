//
//  Pokemon.swift
//  pokedex-by-paul-lozada
//
//  Created by Paul Lozada on 2016-02-28.
//  Copyright © 2016 Paul Lozada. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvolutionText : String!
    private var _pokemonUrl : String!
    private var _nextEvolutionId : String!
    private var _nextEvolutionLevel : String!
    private var _abilities : [String]!
    
    var name : String {
        return _name
    }
    var pokedexId : Int {
        return _pokedexId
    }
    
    var descr: String {
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense : String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText : String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionId : String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }

    var nextEvolutionLevel : String {
        get {
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
        return _nextEvolutionLevel
        }
    }
    
    var abilities : [String] {
        get{
            if _abilities == nil {
                _abilities = [""]
            }
            return _abilities
        }
    }
    
    

    
    init(name: String, pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
        _pokemonUrl = "\(BASE_URL)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadMoveDetails ( ) {
        let url = NSURL(string: "\(BASE_URL)\(URI_ABILITIES)\(pokedexId)")!
        
        Alamofire.request(.GET, url).responseJSON { response in
//            print(response.result.value)
        }
        
//        print(url)
    }
    
    
    func downloadPokemonDetails (completed : DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!

        Alamofire.request(.GET, url).responseJSON { response in
            
    
            
            if let dict = response.result.value as? [String: AnyObject] {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let abil = dict["abilities"] as? [[String: AnyObject]] {
                    print(abil)
                } else {
                    print("nothing found")
                }
            
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [[String:String]] where types.count > 0  {
                    if let type = types[0]["name"] {
                        self._type = type.capitalizedString
                    }
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                    self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                
                if let descArr = dict["descriptions"] as? [[String:String]] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(BASE_URL)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            if let information = response.result.value {
                                self._description = information["description"] as? String
                            }
                            completed ( )
                            
                            if let evolutions = dict["evolutions"] as? [[String: AnyObject]] where evolutions.count > 0 {
                                if let to = evolutions[0]["to"] as? String {
                                    
                                    //Can't suport mega pokemon right now
                                    //Api still has mega data
                                    if to.rangeOfString("mega") == nil {
                                        if let uri = evolutions[0]["resource_uri"] as? String {
                                            let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                            let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                            self._nextEvolutionId = num
                                            self._nextEvolutionText = to
                                            if let lvl = evolutions[0]["level"] as? Int {
                                                self._nextEvolutionLevel = "\(lvl)"
                                            }
                                            
                                            completed ( )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
