//
//  APIError.swift
//  PokemonApp
//
//  Created by kamilcal on 25.03.2023.
//

import Foundation

enum APIError: Error{
    case emptyResponse
    case emptyData
    case clientError(Int)
    case serverError(Int)
    case unexpectedResponse(Int)
}
