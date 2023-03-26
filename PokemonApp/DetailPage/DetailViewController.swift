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
            guard let id = id else {
                return
            }
            viewModel.fetchPokemonDetailPage(id: "\(id)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension DetailViewController: DetailViewModelDelegate {
    
    func pokemonDetailUpdated() {
        guard let pokemonDetail = viewModel.pokemon else { return }
        viewModel.updateUI(with: pokemonDetail, on: self)
    }
    
    func pokemonDetailFetchFailed(with error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Error fetching Pokemon detail.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
}
