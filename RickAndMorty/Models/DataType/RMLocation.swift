//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 07/03/23.
//

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

