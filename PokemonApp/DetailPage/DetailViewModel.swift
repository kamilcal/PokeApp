//
//  DetailViewModel.swift
//  PokemonApp
//
//  Created by kamilcal on 25.03.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func pokemonDetailUpdated()
    func pokemonDetailFetchFailed(with error: Error)
}


class DetailViewModel {
    
     var pokemon: PokemonDetail?{
        didSet {
            if let pokemon = pokemon {
                delegate?.pokemonDetailUpdated()
            }
        }
    }
    weak var delegate: DetailViewModelDelegate?
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClients.shared) {
        self.apiClient = apiClient
    }
    
    
    func fetchPokemonDetailPage(id: String) {
        guard let url = URL(string: APIConstant.baseURL + "pokemon/\(id)"),
              let pokemonId = Int(id) else {
            return
        }
        
        guard pokemonId > 0  else {
            return
        }
        apiClient.getPokemonDetailPage(with: id) { result in
            switch result {
            case .success(let pokemonDetail):
                self.pokemon = pokemonDetail
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.pokemonDetailFetchFailed(with: error)
            }
        }
        print("fetching details for id: \(id)")
        
    }
    
    func updateUI(with pokemonDetail: PokemonDetail, on viewController: DetailViewController) {
        viewController.titleLabel.text = pokemonDetail.name.capitalized
        viewController.abilitiesTitle.text = pokemonDetail.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ")
        
        if let imageUrlString = pokemonDetail.sprites.front_default, let imageUrl = URL(string: imageUrlString) {
            viewController.imageView.sd_setImage(with: imageUrl, completed: nil)
            viewController.backgroundView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
}
