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
            for pokemon in result.results {
                APIClients().getPokemonDetail(url: pokemon.url, completion: { (result: PokemonSelected) in
                    pokemon.imageUrl = result.sprites.front_default
                    self.pokemons.append(pokemon)
                    completion()

                })
            }
        })
    }

}
