//
//  PokemonSelectedModel.swift
//  PokemonApp
//
//  Created by kamilcal on 24.03.2023.
//

import Foundation

struct PokemonDetail : Codable {
    var sprites: PokemonSprites
}

struct PokemonSprites : Codable {
    var front_default: String?
}
