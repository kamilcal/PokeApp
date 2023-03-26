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
    @IBOutlet weak var abilitiesTitleLabel: UILabel!
    
    private var viewModel = DetailViewModel()
    
    var id: Int? {
        didSet {
            guard let id = id else {
                return
            }
            viewModel.fetchPokemonDetailPage(id: "\(id)")
        }
    }
//MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        gradientUI()
    }
}

//MARK: - Extensions

private extension DetailViewController {
    private func gradientUI(){
        let gradientView = Gradient(color: [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)])
        gradientView.frame = view.bounds
        view.addSubview(gradientView)
        view.sendSubviewToBack(gradientView)
    }
}

//MARK: - DetailViewModelDelegate

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
