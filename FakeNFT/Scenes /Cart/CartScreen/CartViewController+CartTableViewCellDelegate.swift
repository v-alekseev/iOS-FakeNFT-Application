//
//  CartViewController+CartTableViewCellDelegate.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//

import Foundation
import UIKit

extension CartViewController: CartTableViewCellDelegate {
    func didDeleteButtonPressed(id: String, image: UIImage) {
        // показать экран
        self.present(CartDeleteViewController(), animated: true)
    }

}
