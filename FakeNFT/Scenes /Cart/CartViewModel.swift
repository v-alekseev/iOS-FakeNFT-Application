//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

protocol CartViewModelDelegate: AnyObject {
    func didUpdateCart()
    func showAlert(message: String)
}

final class CartViewModel {
    
    let cartDataProvider = CardDataProvider()
    weak var delegate: CartViewModelDelegate?
    private (set) var alertMessage: String = "" {
        didSet {
            if !alertMessage.isEmpty {
                delegate?.showAlert(message: alertMessage)
            }
        }
    }
    
    private (set) var order: [NftModel] = [] {
        didSet {
            delegate?.didUpdateCart()
        }
    }
    
    private (set) var totalPrice: Double = 0
    
    init() {
        cartDataProvider.delegate = self
    }
    
    func getOrder() {
        cartDataProvider.getOrder() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                //  сюда никогда не попадаем
              break
            case let .failure(error):
                print("[error] cartDataProvider.getOrder() \(error) / \(error.localizedDescription)")
                self.alertMessage = L10n.Cart.getOrderError
              break
            }
        }
    }
}

extension CartViewModel: CardDataProviderDelegate {
    func didUpdateCart() {
        var tmpOrder: [NftModel] = []
        totalPrice = 0
        for nft in cartDataProvider.order {
            tmpOrder.append(NftModel(nft: nft))
            totalPrice += nft.price
        }
        order = tmpOrder
    }
    
}
