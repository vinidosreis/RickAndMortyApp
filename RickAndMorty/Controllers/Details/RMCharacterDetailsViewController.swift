//
//  RMCharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 13/03/23.
//

import UIKit

final class RMCharacterDetailsViewController: UIViewController {
    private var viewModel: RMCharacterDetailsViewVM

     init(viewModel: RMCharacterDetailsViewVM) {
        self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
