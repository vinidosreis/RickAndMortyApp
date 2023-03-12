//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 07/03/23.
//

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
