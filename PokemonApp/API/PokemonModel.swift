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

struct PokemonResults: Codable{
    
    var name: String
    var url: String
}
