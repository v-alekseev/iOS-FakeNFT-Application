//
//  CartDeleteViewModel.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//

import Foundation
import UIKit

protocol CartDeleteStorageDelegate: AnyObject {
    func nftDeletedFromCart(id: String)
   // func dismiss()
}

protocol CartDeleteDelegate: AnyObject {
    func deleteCompleted()
}

final class CartDeleteViewModel {
    
    private (set) var nftImage: UIImage
    private var nftIDforDelete: String
    private var cartIDs: [String]

    var dataProvider: CardDataProviderProtocol?
    
    var storageDelegate: CartDeleteStorageDelegate?
    var delegate: CartDeleteDelegate?
    
    init(nftImage: UIImage, nftIDforDelete: String, cartIDs: [String], dataProvider: CardDataProviderProtocol? = nil, storageDelegate: CartDeleteStorageDelegate? = nil, delegate: CartDeleteDelegate? = nil) {
        self.nftImage = nftImage
        self.nftIDforDelete = nftIDforDelete
        self.cartIDs = cartIDs
        self.dataProvider = dataProvider
        self.storageDelegate = storageDelegate
        self.delegate = delegate
    }
    
    func deleteNFT() {
        print("before \(cartIDs)")
        cartIDs.removeAll(where: {$0 == nftIDforDelete})
        print("after \(cartIDs)")
        
        dataProvider?.updateCart(ids: cartIDs) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print("Cart after delete - \(data)")
                // говорим что корзина изменилась
                self.storageDelegate?.nftDeletedFromCart(id: nftIDforDelete)
                // говорим что корзина изменилась
                self.delegate?.deleteCompleted()
            case let .failure(error):
               print(error)
            }
        }
        
        
    }
}
