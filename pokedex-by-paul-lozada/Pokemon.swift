//
//  Pokemon.swift
//  pokedex-by-paul-lozada
//
//  Created by Paul Lozada on 2016-02-28.
//  Copyright © 2016 Paul Lozada. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name : String!
    private var _pokedexId : Int!
    
    var name : String {
        return _name
    }
    var pokedexId : Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}