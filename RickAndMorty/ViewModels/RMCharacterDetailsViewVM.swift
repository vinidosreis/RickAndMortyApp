//
//  RMCharacterDetailsViewVM.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 13/03/23.
//

import Foundation

final class RMCharacterDetailsViewVM {
    private let character: RMCharacter
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name
    }
}
