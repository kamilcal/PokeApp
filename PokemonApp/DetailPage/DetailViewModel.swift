//
//  DetailViewModel.swift
//  PokemonApp
//
//  Created by kamilcal on 25.03.2023.
//

import Foundation

class DetailViewModel {

    private var pokemon: PokemonDetail?

    private let baseURL = "https://pokeapi.co/api/v2/"


    func fetchPokemonDetailPage(id: String, completion: @escaping (Result<PokemonDetail?, Error>) -> Void) {
           guard let url = URL(string: baseURL + "pokemon/\(id)"),
                 let pokemonId = Int(id) else {
               print("Invalid URL or ID")
               return
           }

           guard pokemonId > 0 && pokemonId <= 898 else {
               print("Invalid Pokemon ID")
               return
           }
        APIClients().getPokemonDetailPage(with: id) { result in
            switch result {
            case .success(let pokemonDetail):
                self.pokemon = pokemonDetail
                completion(.success(pokemonDetail))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        print("fetching details for id: \(id)") // burada id'yi kontrol etmek için bir print ekleyebilirsiniz

    }


}
