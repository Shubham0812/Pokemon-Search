//
//  HomeViewModel.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 02/03/21.
//

import Foundation

struct HomeViewModel {
    
    // MARK:- variables
    let realmManager: RealmManager
    
    var pokemons: Box<[Pokemon]?> = Box(nil)
    var filteredPokemons: Box<[Pokemon]?> = Box(nil)
    
    var offset: Box<Int> = Box(0)
    var limit: Box<Int> = Box(30)
    
    var searchActive: Box<Bool> = Box(false)
    
    // MARK:- initialisers
    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
            
        self.fetchPokemons()
    }
    
    // MARK:- functions
    func fetchPokemons() {
        let pokemons = realmManager.getPokemonsByID(offset: offset.value, limit: limit.value)
        
        /// Call this method again, data not present in Realm yet/
        if (pokemons.isEmpty) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.fetchPokemons()
            }
            return
        }
        
        if let existingPokemons = self.pokemons.value {
            self.pokemons.value = existingPokemons + pokemons
        } else {
            self.pokemons.value = pokemons
        }
        self.filteredPokemons.value = self.pokemons.value
    }
    
    
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
            resetData()
        }
    }
}

extension HomeViewModel {
    func resetData() {
        if (searchActive.value) {
            self.setSearchState(as: false)
            self.filteredPokemons.value = self.pokemons.value
        }
    }
    
    func fetchMoreDataIfNeeded(displayedRow: Int) {
        if (displayedRow == limit.value - 5 && !searchActive.value) {
            self.offset.value = self.limit.value
            self.limit.value = self.limit.value + 20
            self.fetchPokemons()
        }
    }
    
    func setSearchState(as value: Bool) {
        self.searchActive.value = value
    }
}
