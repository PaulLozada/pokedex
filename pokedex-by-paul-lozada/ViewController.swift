//
//  ViewController.swift
//  pokedex-by-paul-lozada
//
//  Created by Paul Lozada on 2016-02-28.
//  Copyright © 2016 Paul Lozada. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var pokemon = [Pokemon]( )
    var musicPlayer : AVAudioPlayer!
    var inSearchMode = false
    var filteredPokemon = [Pokemon]( )
    
    
    override func viewDidLoad() {
        super.viewDidLoad( )
        
        subsrcibeToDelegates( )
        initAudio( )
        parsePokemonCSV( )
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    
    //MARK: IBOutlet
    @IBOutlet weak var collection : UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:IBAction
    
    @IBAction func musicButtonPressed(sender: UIButton) {
        
        if musicPlayer.playing {
            musicPlayer.stop( )
            sender.alpha = 0.2
        } else {
            musicPlayer.play( )
            sender.alpha = 1.0
        }
    }
    
    //MARK: Functions
    
    
    func subsrcibeToDelegates ( ) {
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
    }
    
    func initAudio ( ) {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay( )
            musicPlayer.numberOfLoops = -1
            musicPlayer.play( )
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }


    
    func parsePokemonCSV ( ) {
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV.init(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]
                let poke = Pokemon(name: name!, pokedexId: pokeId)
                pokemon.append(poke)
            }
            print(rows)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }



    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as?PokeCell {
            
            let poke : Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            
            return cell
            
        } else {
            return UICollectionViewCell ( )
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        var poke : Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
   
    //MARK: SearchBar Delegates
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({
                $0.name.rangeOfString(lower) != nil })
            collection.reloadData( )
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        } else {
            
        }
    }
}

