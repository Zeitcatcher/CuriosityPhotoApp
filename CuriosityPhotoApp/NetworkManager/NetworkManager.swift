//
//  NetworkManager.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/19/23.
//
import Foundation

enum JsonURL: String {
    case nasa =
    """
    https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=SzPwsv57rRbHu6c1h0mVfHEuiG4W3hUICvmNgb7R
    """
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchPhotos(completion: @escaping(Result<PhotoCollection, NetworkError>) -> Void) {
        fetch(PhotoCollection.self, from: JsonURL.nasa.rawValue) { result in
            switch result {
            case .success(let photoCollection):
                completion(.success(photoCollection))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetch<T: Decodable>(_ type: T.Type, from url: String, complition: @escaping(Result<T, NetworkError>) -> Void) {
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
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(type))
                }
            } catch let error {
                print("Decoding Error: \(error)")
                complition(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
}
