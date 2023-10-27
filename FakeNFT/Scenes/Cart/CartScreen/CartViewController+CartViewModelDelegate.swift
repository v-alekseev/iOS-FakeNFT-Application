//
//  CartViewController+CartViewModelDelegate.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import Foundation

extension CartViewController: CartViewModelDelegate {
    /// Сейчас начнется процесс обновления корзины
    func willUpdateCart() {
        showLoader(true)
    }
    /// Изменилась корзина
    func didUpdateCart() {
        updateTotal()
        cartTable.reloadData()
        showLoader(false)
    }
    
    /// Нужно показать сообщение
    func showAlert(message: String) {
       // showLoader(false)
        Alert.alertInformation(viewController: self, text: message)
    }
    ///  данных в корзине нет
    func hideCartEvent(hide: Bool) {
        hideCart(hide)
    }
}
