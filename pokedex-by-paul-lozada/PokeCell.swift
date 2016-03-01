//
//  PokeCell.swift
//  pokedex-by-paul-lozada
//
//  Created by Paul Lozada on 2016-02-29.
//  Copyright © 2016 Paul Lozada. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder : NSCoder){
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10
        
    }

    func configureCell(pokemon : Pokemon){
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
