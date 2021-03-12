//
//  Service.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation
import UIKit

class Service {

    static func fetchAndParse<T>(from url: URL, modelType: T.Type, completion: @escaping ((Result<T, Error>)) -> Void) where T : Decodable {
        let request = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                if let data = data {
                    let parsed = try! JSONDecoder().decode(modelType, from: data)
                    completion(.success(parsed))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
        session.resume()
    }
    
    static func downloadImageAndCache(from url: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil else { return }
                completion(data)
            }
        }.resume()
    }
}
