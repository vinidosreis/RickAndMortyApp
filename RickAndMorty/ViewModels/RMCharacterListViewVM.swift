//
//  RMCharacterListViewVM.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 10/03/23.
//

import UIKit

protocol RMCharacterListViewVMDelegate: AnyObject {
   func didInicialFetch()
    func didFetchMoreCharacters(newIndex: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewVM: NSObject {
    public weak var delegate: RMCharacterListViewVMDelegate?
    private var cellViewModels: [RMCharacterCollectionViewCellVM] = []
    private var responseInfo: RMGetAllCharacters.Info? = nil
    private var isLoadingMoreCharacters = false
    private var characters: [RMCharacter] = [] {
        didSet {
            let newViewModels = characters.map {
                RMCharacterCollectionViewCellVM(characterName: $0.name,
                                                 chacharacterStatus: $0.status,
                                                 chacharacterImageUrl: URL(string: $0.image))
            }
            cellViewModels.append(contentsOf: newViewModels.filter { !cellViewModels.contains($0) })
        }
    }
    
   public func fetchCharacters() {
        RMService.shared.execute(.listCharacters, expecting: RMGetAllCharacters.self) { [weak self] result in
            switch result {
            case .success(let model):
                let result = model.results
                let info = model.info
                self?.characters = result
                self?.responseInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didInicialFetch()
                }
            case .failure(let error):
                print( "O erro é esse: \(error)")
            }
        }
    }
    
    public func fetchMoreCharacters(url: URL) {
        guard !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }

        RMService.shared.execute(request, expecting: RMGetAllCharacters.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                let result = model.results
                let info = model.info
                let originalCounte = self.characters.count
                let newCount = result.count
                let total = originalCounte + newCount
                let startingIndex = total - newCount
                let indexToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    IndexPath(row: $0, section: 0)
                }
                
                self.characters.append(contentsOf: result)
                self.responseInfo = info
                DispatchQueue.main.async {
                    self.delegate?.didFetchMoreCharacters(newIndex: indexToAdd)
                    self.isLoadingMoreCharacters = false
                }
            case .failure( let failure):
                self.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldReloadMore: Bool {
        responseInfo?.next != nil
    }
    
    
}

extension RMCharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.id, for: indexPath) as? RMCharacterCollectionViewCell else { return UICollectionViewCell() }
        let viewModel = cellViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds.width
        let width = (bounds - 30) / 2
        return CGSize(width: width,
                      height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.id, for: indexPath) as? RMFooterLoadingCollectionReusableView else { return UICollectionReusableView() }

        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldReloadMore else { return .zero }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension RMCharacterListViewVM: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

extension RMCharacterListViewVM: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldReloadMore,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrl = responseInfo?.next,
              let url = URL(string: nextUrl) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let fixedHeight = scrollView.frame.size.height
            
            if offset >= (contentHeight - fixedHeight) {
                self?.fetchMoreCharacters(url: url)
            }
            timer.invalidate()
        }
    }
}


