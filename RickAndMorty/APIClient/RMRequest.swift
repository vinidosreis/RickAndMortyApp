//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 08/03/23.
//

import Foundation

final class RMRequest {
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
    
    private let endpoint: RMEndpoint
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { string += "/\($0)" }
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argument = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "& ")
            
            string += argument
        }
        
        return string
    }
    
    public var url: URL? {
        URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl, with: "")
        if trimmed.contains("/") {
            let componemts = trimmed.components(separatedBy: "/")
            if !componemts.isEmpty {
                let endpointString = componemts[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let componemts = trimmed.components(separatedBy: "?")
            if !componemts.isEmpty, componemts.count >= 2 {
                let endpointString = componemts[0]
                let queryItemsString = componemts[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap {
                    guard $0.contains("=") else { return nil }
                    let parts = $0.components(separatedBy: "=")
                   return URLQueryItem(name: parts[0], value: parts[1])
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest {
    static let listCharacters = RMRequest(endpoint: .character)
}
