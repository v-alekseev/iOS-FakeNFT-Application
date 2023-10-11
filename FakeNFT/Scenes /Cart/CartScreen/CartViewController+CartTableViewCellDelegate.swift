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
        let deleteVC = CartDeleteViewController()
        deleteVC.modalPresentationStyle = .overCurrentContext // .fullScreen //.overCurrentContext //.fullScreen
        deleteVC.nftImage = image
        deleteVC.nftID = id
        self.tabBarController?.present(deleteVC, animated: true)
    }

}
