//
//  Pokemon.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 28/02/21.
//

import Foundation
import RealmSwift

class Pokemon: Object, Decodable {
    
    // MARK:- variables
    @objc dynamic var id: Int = 0
    @objc dynamic var pokemonNumber: String = ""
    
    @objc dynamic var name: String = ""
    @objc dynamic var imageURL: String = ""
    
    @objc dynamic var type: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var weight: String = ""
    
    /// computed property
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
    
    // Primary key for Realm Entity. Required
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // properties that are either computed and lazy are mentioned here
    // since Realm cannnot store those.
    override static func ignoredProperties() -> [String] {
        ["pokemonType"]
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
