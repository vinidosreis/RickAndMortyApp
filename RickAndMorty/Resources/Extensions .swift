//
//  Extensions .swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 11/03/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
