//
//  APIClients.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import Foundation

protocol APIClientProtocol {
    func APIRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func pokemonDetail(with id: String, completion: @escaping (Result<PokemonDetail?, Error>) -> Void)
    func pokemonImege(url: URL, completion: @escaping (Result<PokemonSelected, Error>) -> Void)
}


class APIClients: APIClientProtocol {
    
    static let shared = APIClients()

    private var dataTask: URLSessionDataTask?
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func APIRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.emptyResponse))
                return
            }

            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data, let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(APIError.emptyData))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            case 400...499:
                completion(.failure(APIError.clientError(httpResponse.statusCode)))
            case 500...599:
                completion(.failure(APIError.serverError(httpResponse.statusCode)))
            default:
                completion(.failure(APIError.unexpectedResponse(httpResponse.statusCode)))
            }
        }
        task.resume()
    }
    
    func pokemonDetail(with id: String, completion: @escaping (Result<PokemonDetail?, Error>) -> Void) {
        guard let url = URL(string: APIConstant.baseURL + "pokemon/\(id)") else { return }
        APIRequest(url: url, completion: completion)
    }

    func pokemonImege(url: URL, completion: @escaping (Result<PokemonSelected, Error>) -> Void) {
        APIRequest(url: url, completion: completion)
    }
}
