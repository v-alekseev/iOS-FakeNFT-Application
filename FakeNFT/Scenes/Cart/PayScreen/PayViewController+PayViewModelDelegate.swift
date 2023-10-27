//
//  PayViewController+PayViewModelDelegate.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import Foundation

extension PayViewController: PayViewModelDelegate {
    func willDoPayment() {
        showLoader(true)
        enablePayButton(false)
    }
    
    func didPayment(result: Bool) {
        showLoader(false)
        enablePayButton(true)
        if result {
            let vc = PayResultViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                self.navigationController?.popViewController(animated: true)
                self.tabBarController?.selectedViewController =  self.tabBarController?.viewControllers?[1]
            }
        } else {
            Alert.alertInformation(viewController: self, text: L10n.Cart.PayResultScreen.errorAlertMessage, title: L10n.Cart.PayResultScreen.errorAlertTitle)
        }
    }
    
    func didSelectCurrency() {
        enablePayButton(true)
    }
    
    func willUpdateCurrensies() {
        showLoader(true)
    }
    
    func didUpdateCurrensies() {
        showLoader(false)
        self.currencyCollectionView.reloadData()
    }
}
