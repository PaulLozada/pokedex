//
//  PokemonDetailVC.swift
//  pokedex-by-paul-lozada
//
//  Created by Paul Lozada on 2016-02-29.
//  Copyright © 2016 Paul Lozada. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon : Pokemon!
    
    
    //MARK: IBAction
    @IBAction func backButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name.capitalizedString
        var img = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImage.image = img
        nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
        mainImg.image = img
        
        pokemon.downloadPokemonDetails {
            //this will be called after the download is done
            self.updateUI()
        }

        // Do any additional setup after loading the view.
    }

    func updateUI ( ) {
        descriptionLbl.text = pokemon.descr
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexLabel.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvolutionText == "" {
            evoLabel.text = "No Evolutions"
            nextEvoImage.hidden = true
        } else {
            nextEvoImage.hidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            print(pokemon.nextEvolutionText)
            evoLabel.text = pokemon.nextEvolutionText
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
