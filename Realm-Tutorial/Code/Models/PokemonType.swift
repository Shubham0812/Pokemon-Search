//
//  PokemonType.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 03/03/21.
//

import UIKit

enum PokemonTypeColor: String {
    case grass
    case poison
    case fire
    case water
    case normal
    case fighting
    case flying
    case ground
    case rock
    case bug
    case ghost
    case steel
    case electric
    case psychic
    case ice
    case dragon
    case fairy
    case dark
    
    func getColor() -> UIColor {
        switch self {
        case .grass:
            return UIColor(hex: "#A7DB8D")
        case .poison:
            return UIColor(hex: "#C183C1")
        case .fire:
            return UIColor(hex: "#F5AC78")
        case .water:
            return UIColor(hex: "#F5AC78")
        case .normal:
            return UIColor(hex: "#C6C6A7")
        case .fighting:
            return UIColor(hex: "#D67873")
        case .flying:
            return UIColor(hex: "#C6B7F5")
        case .ground:
            return UIColor(hex: "#EBD69D")
        case .rock:
            return UIColor(hex: "#D1C17D")
        case .bug:
            return UIColor(hex: "#C6D16E")
        case .ghost:
            return UIColor(hex: "#A292BC")
        case .steel:
            return UIColor(hex: "#9DB7F5")
        case .electric:
            return UIColor(hex: "#FAE078")
        case .psychic:
            return UIColor(hex: "#FA92B2")
        case .ice:
            return UIColor(hex: "#BCE6E6")
        case .dragon:
            return UIColor(hex: "#A27DF9")
        case .fairy:
            return UIColor(hex: "#F4BDC9")
        case .dark:
            return UIColor(hex: "#A29288")
            
        }
    }
}


