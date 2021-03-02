//
//  AppDelegate.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 28/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK:- variables
    var window: UIWindow?
    
    // MARK:- functions‹
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        storeData()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        return true
    }
    
    func storeData() {
        let urlString = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, _, error) in
            if (error == nil) {
                guard let data = data else { return }
                do {
                    let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    print("Pokemon count", pokemonResponse.pokemon.count)
                    
                    /// ADD & STORE the data to Realm
                    RealmManager.add(pokemonResponse.pokemon)
                } catch { print(error) }
            }
        }
        task.resume()
    }
}

