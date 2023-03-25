//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abilitiesTitle: UILabel!
    @IBOutlet weak var pokeView: UIImageView!
    
    private var viewModel = DetailViewModel()
    
    var id: Int? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        getDetail()
    }
    
    func getDetail() {
        guard let id = id else {
            print("id is nil")
            return
        }
        viewModel.fetchPokemonDetailPage(id: "\(id)") { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.updateUI(pokemonDetail!)
            case .failure(let error):
                print("Error fetching Pokemon detail: \(error.localizedDescription)")
            }
        }
    }

    
    func updateUI(_ pokemonDetail: PokemonDetail) {
        titleLabel.text = pokemonDetail.name.capitalized
        abilitiesTitle.text = pokemonDetail.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ")

        if let imageUrlString = pokemonDetail.sprites.front_default, let imageUrl = URL(string: imageUrlString) {
            imageView.sd_setImage(with: imageUrl, completed: nil)
            backgroundView.sd_setImage(with: imageUrl, completed: nil)

        }
    }
}
