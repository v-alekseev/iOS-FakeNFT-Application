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
    
    var totalPrice: Double  {
        get {
            var price: Double = 0
            for nft in order {
                price += nft.price
            }
            return price
        }
    }
    
    var cartNftIDs: [String] {
        get {
            order.map { $0.id }
        }
    }
    
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
    func cartLoaded() {
        var tmpOrder: [NftModel] = []
        // totalPrice = 0
        for nft in cartDataProvider.order {
            tmpOrder.append(NftModel(nft: nft))
            //totalPrice += nft.price
        }
        order = tmpOrder
    }
    
}

extension CartViewModel: CartDeleteStorageDelegate {
    func nftDeletedFromCart(id: String) {
        order = order.compactMap { $0.id != id  ?  $0 : nil}
    }
}
