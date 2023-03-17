//
//  RMCharacterCollectionViewCellVM.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 12/03/23.
//

import Foundation

final class RMCharacterCollectionViewCellVM: Hashable, Equatable {
    public let characterName: String
    private let chacharacterStatus: RMCharacterStatus
    private let chacharacterImageUrl: URL?
    
    static func == (lhs: RMCharacterCollectionViewCellVM, rhs: RMCharacterCollectionViewCellVM) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(chacharacterStatus)
        hasher.combine(chacharacterImageUrl)
    }
    
    init(characterName: String, chacharacterStatus: RMCharacterStatus, chacharacterImageUrl: URL?) {
        self.characterName = characterName
        self.chacharacterStatus = chacharacterStatus
        self.chacharacterImageUrl = chacharacterImageUrl
    }
    
    public var chacharacterStatusText: String {
        "Status: \(chacharacterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = chacharacterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url: url, completion: completion)
    }
}
