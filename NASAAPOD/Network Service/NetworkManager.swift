//
//  NetworkManager.swift
//  NASAAPOD
//
//  Created by Malik Em on 10.02.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(APIKey.key)"
    
    func getAPOD(completion: @escaping (Result<DataResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(DataResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

