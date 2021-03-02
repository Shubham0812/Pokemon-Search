//
//  HomeViewModel.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 02/03/21.
//

import UIKit

class HomeViewModel {
    
    // MARK:- variables
    let realmManager: RealmManager
    
    var pokemons: Box<[Pokemon]?> = Box(nil)
    var filteredPokemons: Box<[Pokemon]?> = Box(nil)
    
    var offset = 0
    var limit = 100
    
    var searchActive = false
    
    // MARK:- initialisers
    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
            
        self.fetchPokemons()
    }
    
    // MARK:- Searchupdating delegates
    func searchPokemons(with query: String?) {
        if let query = query, query.count > 0 {
            self.setSearchState(as: true)
            if (query.lowercased().hasPrefix("type")) {
                let queryComponents = query.components(separatedBy: "=")
                if (queryComponents.count > 1) {
                    /// search by type
                    self.filteredPokemons.value = realmManager.getPokemonsByType(query: queryComponents[1])
                }
            }
            else {
                /// search by name
                self.filteredPokemons.value = realmManager.getPokemonsByName(query: query)
            }
        } else {
            resetDataIfNeeded()
        }
    }
    
    // MARK:- functions
    func fetchPokemons() {
        let pokemons = realmManager.getPokemonsByID(offset: offset, limit: limit)
        
        if let existingPokemons = self.pokemons.value {
            self.pokemons.value = existingPokemons + pokemons
        } else {
            self.pokemons.value = pokemons
        }
        self.filteredPokemons.value = self.pokemons.value
    }
    
    func resetDataIfNeeded() {
        guard let filteredPokemons = self.filteredPokemons.value, let pokemons = self.pokemons.value else { return }
        if (filteredPokemons.count != pokemons.count) {
            self.setSearchState(as: false)
            self.filteredPokemons.value = self.pokemons.value
        }
    }
    
    func fetchMoreDataIfNeeded(displayedRow: Int) {
        if (displayedRow == limit - 5 && !searchActive) {
            self.offset = self.limit
            self.limit = self.limit + 20
            self.fetchPokemons()
        }
    }
    
    func setSearchState(as value: Bool) {
        self.searchActive = value
    }
}
