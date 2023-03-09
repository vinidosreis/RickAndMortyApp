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
    
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
    
}
