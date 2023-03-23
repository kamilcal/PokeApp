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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    
//}
//
//private extension ListTableViewCell{
    
    private func setupUI(){
        
        
        backgroundImage.layer.cornerRadius = 10
        titleLabel.text = "dasda"
        contentImageView.layer.cornerRadius = 10
        contentImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
    }
}
