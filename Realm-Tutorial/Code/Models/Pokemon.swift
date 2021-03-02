//
//  Pokemon.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 28/02/21.
//

import UIKit
import RealmSwift


/// JSON structure
let json = """
{
  "id": 1,
  "num": "001",
  "name": "Bulbasaur",
  "img": "http://www.serebii.net/pokemongo/pokemon/001.png",
  "height": "0.71 m",
  "weight": "6.9 kg",
}
""".data(using: .utf8)

struct PokemonResponse: Decodable {
    var pokemon: [Pokemon]
}

class Pokemon: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var pokemonNumber: String = ""
    
    @objc dynamic var name: String = ""
    @objc dynamic var imageURL: String = ""
    
    @objc dynamic var type: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var weight: String = ""
    
    var pokemonType: [String] {
        get {
            return type.components(separatedBy: "|")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case pokemonNumber = "num"
        case name = "name"
        case imageURL = "img"
        case type = "type"
        case height = "height"
        case weight = "weight"
    }
    
    // MARK:- initialisers
    override required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        pokemonNumber = try container.decode(String.self, forKey: .pokemonNumber)
        
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        
        height = try container.decode(String.self, forKey: .height)
        weight = try container.decode(String.self, forKey: .weight)
        
        if let type = try? container.decode([String].self, forKey: .type) {
            self.type = type.joined(separator: "|")
        }
    }
    
    // Primary key is declared here. REQUIRED
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // properties that are either computed and lazy are mentioned here
    // since Realm cannnot store those.
    override static func ignoredProperties() -> [String] {
        ["pokemonType"]
    }
}

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








////

/*
 import Foundation
 import RealmSwift
 
 
 /// JSON structure
 let json = """
 {
 "id": 1,
 "num": "001",
 "name": "Bulbasaur",
 "img": "http://www.serebii.net/pokemongo/pokemon/001.png",
 "type": [
 "Grass",
 "Poison"
 ],
 "height": "0.71 m",
 "weight": "6.9 kg",
 }
 """.data(using: .utf8)
 
 class Pokemon: Object, Decodable {
 @objc dynamic var id: Int = 0
 @objc dynamic var pokemonNumber: String = ""
 
 @objc dynamic var name: String = ""
 @objc dynamic var imageURL: String = ""
 
 @objc dynamic var type: String = ""
 @objc dynamic var height: String = ""
 @objc dynamic var weight: String = ""
 
 var pokemonType: [String] {
 get {
 return type.components(separatedBy: "|")
 }
 }
 
 private enum CodingKeys: String, CodingKey {
 case id = "id"
 case pokemonNumber = "num"
 case name = "name"
 case imageURL = "img"
 case type = "type"
 case height = "height"
 case weight = "weight"
 }
 
 // MARK:- initialisers
 override required init() {
 super.init()
 }
 
 required init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: CodingKeys.self)
 
 id = try container.decode(Int.self, forKey: .id)
 pokemonNumber = try container.decode(String.self, forKey: .pokemonNumber)
 
 name = try container.decode(String.self, forKey: .name)
 imageURL = try container.decode(String.self, forKey: .imageURL)
 
 height = try container.decode(String.self, forKey: .height)
 weight = try container.decode(String.self, forKey: .weight)
 
 if let type = try? container.decode([String].self, forKey: .type) {
 self.type = type.joined(separator: "|")
 }
 }
 
 override static func primaryKey() -> String? {
 return "id"
 }
 
 override static func ignoredProperties() -> [String] {
 ["pokemonType"]
 }
 }
 
 */
