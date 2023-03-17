//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 17/03/23.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    private var imageCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageCache.object(forKey: key){
            completion(.success(data as Data))
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
