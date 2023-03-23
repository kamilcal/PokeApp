//
//  ListViewModel.swift
//  PokemonApp
//
//  Created by kamilcal on 24.03.2023.
//

import Foundation

class ListViewModel {
    var pokemons: [PokemonResults] = []
    
    func getPokemonList(completion: @escaping () -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50")!
        APIClients().makeAPIRequest(url: url, completion: { (result: Pokemon) in
            self.pokemons = result.results
            completion()
        })
    }
}
