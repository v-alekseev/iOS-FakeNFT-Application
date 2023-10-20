//
//  CartDeleteViewModel.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//
import UIKit

protocol CartDeleteViewModelProtocol {
    var nftImage: UIImage { get }
    var dataProvider: CardDataProviderProtocol? {get set}
    
    init(nftImage: UIImage, nftIDforDelete: String, dataProvider: CardDataProviderProtocol?)
    func deleteNFT( _ completion: @escaping (Result<[String], Error>) -> Void)
}

final class CartDeleteViewModel: CartDeleteViewModelProtocol {
    
    private (set) var nftImage: UIImage
    private var nftIDforDelete: String
    
    var dataProvider: CardDataProviderProtocol?
    
    init(nftImage: UIImage, nftIDforDelete: String, dataProvider: CardDataProviderProtocol? = nil) {
        self.nftImage = nftImage
        self.nftIDforDelete = nftIDforDelete
        self.dataProvider = dataProvider
    }
    
    func deleteNFT( _ completion: @escaping (Result<[String], Error>) -> Void)  {
        // TODO: Показать лоадер
        dataProvider?.removeItemFromCart(idForRemove: nftIDforDelete) { result in
            switch result {
            case let .success(data):
                //TODO:  убрать лоадер
                completion(.success(data))
            case let .failure(error):
                print(error)
            }
        }
    }
}
