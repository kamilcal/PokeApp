//
//  PokemonModel.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import Foundation

struct Pokemon: Codable{
    var results: [PokemonResults]
    
}

class PokemonResults: Codable {
    var name: String
    var url: URL
    var imageUrl: String?
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
