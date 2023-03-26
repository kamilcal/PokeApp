//
//  ListViewModel.swift
//  PokemonApp
//
//  Created by kamilcal on 24.03.2023.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func pokemonListDidUpdate()
    func pokemonListDidFailToUpdate(error: Error)
}

class ListViewModel {
    
    var pokemonList: [PokemonResults] = []
    weak var delegate: PokemonListViewModelDelegate?

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClients.shared) {
        self.apiClient = apiClient
    }

    func getPokemonList() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50")!
        apiClient.makeAPIRequest(url: url) { [weak self] (result: Result<Pokemon, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let pokemonList):
                self.pokemonList = pokemonList.results
                self.fetchPokemonDetails()
            case .failure(let error):
                self.delegate?.pokemonListDidFailToUpdate(error: error)
            }
        }
    }

    private func fetchPokemonDetails() {
        let group = DispatchGroup()
        for pokemon in pokemonList {
            group.enter()
            if let url = URL(string: pokemon.url) {
                apiClient.getPokemonDetail(url: url) { [weak self] (result: Result<PokemonSelected, Error>) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let pokemonSelected):
                        pokemon.imageUrl = pokemonSelected.sprites.front_default
                        group.leave()
                    case .failure(let error):
                        print("Failed to get pokemon detail: \(error.localizedDescription)")
                        group.leave()
                    }
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.delegate?.pokemonListDidUpdate()
        }
    }

    func getPokemonId(at index: Int) -> String? {
        let urlString = pokemonList[index].url
        if let id = urlString.split(separator: "/").last {
            return String(id)
        }
        return nil
    }
    
    var pokemonListCount: Int {
        pokemonList.count
    }

}
