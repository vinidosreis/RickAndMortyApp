//
//  RMGetAllCharacters.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 10/03/23.
//

import Foundation

struct RMGetAllCharacters: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}
