//
//  CharacterListViewVM.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 10/03/23.
//

import UIKit

final class CharacterListViewVM: NSObject {

    
    func fetchCharacters() {
        RMService.shared.execute(.listCharacters, expecting: RMGetAllCharacters.self) { result in
            switch result {
            case .success(let model):
                print(model.info.pages)
            case .failure(let error):
                print( "O erro é esse: \(error)")
            }
        }
    }
}

extension CharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (collectionView.bounds.width - 30) / 2
        return CGSize(width: width,
                      height: width * 1.5)
    }
}


