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

    private let dataProvider = CardDataProvider()
    
    var storageDelegate: CartDeleteStorageDelegate?
    var delegate: CartDeleteDelegate?
    
    
    init(nftImage: UIImage, nftID: String, cartIDs: [String]) {
        self.nftImage = nftImage
        self.nftIDforDelete = nftID
        self.cartIDs = cartIDs
    }
    
    func deleteNFT() {
        print("before \(cartIDs)")
        cartIDs.removeAll(where: {$0 == nftIDforDelete})
        print("after \(cartIDs)")
        
        dataProvider.updateCart(ids: cartIDs) { [weak self] result in
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
