//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 07/03/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }
    
    private func setUpView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RMCharacterViewController: RMCharacterListViewDelegate {
    func rmCharacterListView(_ view: RMCharacterListView, selectedCharacter: RMCharacter) {
        let viewModel = RMCharacterDetailsViewVM(character: selectedCharacter)
        let detailsVC = RMCharacterDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
