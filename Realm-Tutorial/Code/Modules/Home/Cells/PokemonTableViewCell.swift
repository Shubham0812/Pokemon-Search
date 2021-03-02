//
//  PokemonTableViewCell.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 01/03/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK:- outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    // MARK:- variables
    override class func description() -> String {
        return "PokemonTableViewCell"
    }
    
    // MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- functions
    func setupCell(pokemon: Pokemon) {
        self.pokemonName.text = pokemon.name
        self.pokemonNumber.text = "#\(pokemon.id)"
    }
}
