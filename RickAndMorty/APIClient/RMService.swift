//
//  RMService.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 08/03/23.
//

import Foundation

final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    /// Send API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T,Error>) -> Void
    ) {
        
    }
    
}
