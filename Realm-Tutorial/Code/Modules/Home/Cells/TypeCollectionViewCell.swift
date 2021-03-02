//
//  TypeCollectionViewCell.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 02/03/21.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {

    // MARK:- outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    // MARK:- variables
    override class func description() -> String {
        return "TypeCollectionViewCell"
    }
    
    // MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 16
    }
    
    // MARK:- functions
    func setupCell(type: String) {
        self.typeLabel.text = type
        self.containerView.backgroundColor = PokemonTypeColor(rawValue: type.lowercased())?.getColor()
    }
}
