//
//  DetailModel.swift
//  PokemonApp
//
//  Created by kamilcal on 24.03.2023.
//

import Foundation

struct PokemonDetail: Codable {
    let abilities: [Ability]
    let id: Int
    let name: String
    let sprites: Sprites
}

struct Ability: Codable {
    let ability: AbilityDetail
}

struct AbilityDetail: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String?
}
