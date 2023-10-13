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
        
        let deleteViewModel = CartDeleteViewModel(nftImage: image, nftIDforDelete: id, cartIDs: viewModel.cartNftIDs)
        deleteViewModel.dataProvider = CardDataProvider()
        deleteViewModel.delegate = deleteVC
        deleteViewModel.storageDelegate =  self.viewModel
        
        deleteVC.viewModel = deleteViewModel
        deleteVC.modalPresentationStyle = .overCurrentContext
        
        self.tabBarController?.present(deleteVC, animated: true)
    }

}
