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
        deleteVC.viewModel = CartDeleteViewModel(nftImage: image, nftID: id, cartIDs: viewModel.cartNftIDs)
        deleteVC.viewModel?.delegate = deleteVC
        deleteVC.viewModel?.storageDelegate =  self.viewModel
        deleteVC.modalPresentationStyle = .overCurrentContext
        
        self.tabBarController?.present(deleteVC, animated: true)
    }

}
