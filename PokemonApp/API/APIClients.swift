//
//  APIClients.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import Foundation

class APIClients {
    
    private var dataTask: URLSessionDataTask?
    
    static let shared = APIClients()

    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func makeAPIRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }

            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data, let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    print("Empty Data or Failed to decode JSON")
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            case 400...499:
                print("Client Error: \(httpResponse.statusCode)")
            case 500...599:
                print("Server Error: \(httpResponse.statusCode)")
            default:
                print("Unexpected Response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
    
    func getPokemonDetailPage(with id: String, completion: @escaping (Result<PokemonDetail?, Error>) -> Void) {
        guard let url = URL(string: baseURL + "pokemon/\(id)") else { return }
        makeAPIRequest(url: url, completion: completion)
    }

    func getPokemonDetail(url: URL, completion: @escaping (Result<PokemonSelected, Error>) -> Void) {
        makeAPIRequest(url: url, completion: completion)
    }
}
