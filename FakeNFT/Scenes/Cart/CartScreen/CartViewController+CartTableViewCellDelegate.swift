//
//  CartViewController+CartTableViewCellDelegate.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//

import UIKit

extension CartViewController: CartTableViewCellDelegate {
    func didDeleteButtonPressed(id: String, image: UIImage) {
        // переход на экран удаления из корзины
        
        let deleteViewModel = CartDeleteViewModel(nftImage: image, nftIDforDelete: id, dataProvider: CardDataProvider.shared)
        
        let deleteVC = CartDeleteViewController()
        deleteVC.viewModel = deleteViewModel
        deleteVC.modalPresentationStyle = .overCurrentContext
        
        self.tabBarController?.present(deleteVC, animated: true)
    }

}
