//
//  PokemonModel.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import Foundation

struct Pokemon: Decodable{
    var results: [PokemonResults]
    
}

class PokemonResults: Decodable {
    var id: Int?
    var name: String
    var url: String
    var imageUrl: String?
    
    init(id: Int, name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }
}
