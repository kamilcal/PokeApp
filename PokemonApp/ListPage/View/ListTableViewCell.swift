//
//  ListTableViewCell.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

//MARK: - Lifecycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

//MARK: - Funcs

    func configure(with pokemon: PokemonResults) {
        titleLabel.text = pokemon.name
        
        if let imageUrlString = pokemon.imageUrl, let imageUrl = URL(string: imageUrlString) {
            contentImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
}

//MARK: - Extensions
private extension ListTableViewCell {

    private func setupUI(){
        backgroundImage.layer.cornerRadius = 10
        titleLabel.text = "dasda"
        contentImageView.layer.cornerRadius = 10
        contentImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
}
