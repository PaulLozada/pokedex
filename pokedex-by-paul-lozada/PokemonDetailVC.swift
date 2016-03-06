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
    
    @IBAction func segmentedControlPressed(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.descriptionLbl.hidden = false
        } else if sender.selectedSegmentIndex == 1 {
            hide( )
            self.descriptionLbl.hidden = false
            self.descriptionLbl.text = pokemon.abilities[0]
        }
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
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var evoImageStackView: UIStackView!
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var defenseStackView: UIStackView!
    @IBOutlet weak var heightStackView: UIStackView!
    @IBOutlet weak var weightStackView: UIStackView!
    @IBOutlet weak var baseAttackStackView: UIStackView!
    @IBOutlet weak var pokedexStackView: UIStackView!
    @IBOutlet weak var redViewSeperator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImage.image = img
        nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
        mainImg.image = img
        
        
        pokemon.downloadMoveDetails()
        
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
        attackLabel.text = pokemon.attack
        weightLabel.text = pokemon.weight
        
        if pokemon.nextEvolutionText == "" {
            evoLabel.text = "No Evolutions"
            nextEvoImage.hidden = true
        } else {
            nextEvoImage.hidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            evoLabel.text = pokemon.nextEvolutionText
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hide ( ) {
        mainImg.hidden = true
        descriptionLbl.hidden = true
        typeLabel.hidden = true
        defenseLabel.hidden = true
        heightLabel.hidden = true
        pokedexLabel.hidden = true
        currentEvoImage.hidden = true
        nextEvoImage.hidden = true
        evoLabel.hidden = true
        attackLabel.hidden = true
        weightLabel.hidden = true
        evoImageStackView.hidden = true
        typeStackView.hidden = true
        defenseStackView.hidden = true
        heightStackView.hidden = true
        weightStackView.hidden = true
        baseAttackStackView.hidden = true
        pokedexStackView.hidden = true
        redViewSeperator.hidden = true
        lineView.hidden = true
        
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
