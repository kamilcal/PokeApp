//
//  APIClients.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import Foundation

class APIClients {
    
    private var dataTask: URLSessionDataTask?
    
    func makeAPIRequest<T: Decodable>(url: URL, completion: @escaping (T) -> Void) {
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
                    completion(decodedResponse)
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

//    func getData(completion: @escaping ([PokemonResults]) -> Void) {
//        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=50"
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Empty Response")
//                return
//            }
//
//            switch httpResponse.statusCode {
//            case 200...299:
//                guard let data = data, let pokemonList = try? JSONDecoder().decode(Pokemon.self, from: data) else {
//                    print("Empty Data or Failed to decode JSON")
//                    return
//                }
//                DispatchQueue.main.async {
//                    completion(pokemonList.results)
//                }
//            case 400...499:
//                print("Client Error: \(httpResponse.statusCode)")
//            case 500...599:
//                print("Server Error: \(httpResponse.statusCode)")
//            default:
//                print("Unexpected Response: \(httpResponse.statusCode)")
//            }
//            self?.dataTask = nil
//        }
//        dataTask?.resume()
//    }
//
//    func getSprite(url: String, completion:@escaping (PokemonSprites) -> ()) {
//          guard let url = URL(string: url) else { return }
//
//          URLSession.shared.dataTask(with: url) { (data, response, error) in
//              guard let data = data else { return }
//
//              let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data)
//
//              DispatchQueue.main.async {
//                  completion(pokemonSprite.sprites)
//              }
//          }.resume()
//      }
}
