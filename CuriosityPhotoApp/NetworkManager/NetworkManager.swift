//
//  NetworkManager.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/19/23.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, complition: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                complition(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(type))
                }
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
}
