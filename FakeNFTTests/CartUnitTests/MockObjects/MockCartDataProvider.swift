//
//  MockCartDataProvider.swift
//  FakeNFTTests
//
//  Created by Vitaly on 21.10.2023.
//

import Foundation
@testable import FakeNFT
import XCTest


class MockCartDataProvider : CardDataProviderProtocol {
    var sampleOrder = [NftDto(createdAt: "2023-04-20T02:22:27Z", name: "Rosie", images: ["1.png"], rating: 3, description: "text", price: 10, author: "30", id: "1"),
                      NftDto(createdAt: "2023-04-20T02:22:27Z", name: "Toast", images: ["2.png"], rating: 5, description: "descr", price: 3.9, author: "12", id: "2")]

    var removeItemFromCart: Bool
    var getOrderResult: Bool
    
    let orderChanged = Notification.Name("TestCartUpdated")
    
    private (set) var order: [NftDto] = [] {
        didSet {
                NotificationCenter.default.post(name: orderChanged, object: nil )
        }
    }
    
    init(removeItemFromCart: Bool = true, getOrderResult: Bool = true ) {
        self.removeItemFromCart = removeItemFromCart
        self.getOrderResult = getOrderResult
    }

    func getOrder(_ completion: @escaping (Result<String, Error>) -> Void) {
        if(getOrderResult) {
            completion(.success("ok"))
            order = sampleOrder
        } else {
            completion(.failure(NetworkClientError.httpStatusCode(404)))
        }
    }
    
    func getNFT(id: String, _ completion: @escaping (Result<FakeNFT.NftDto, Error>) -> Void) {
        
    }
    
    func removeItemFromCart(idForRemove: String, _ completion: @escaping (Result<[String], Error>) -> Void) {
        if(removeItemFromCart) {
            completion(.success(["1","2"]))
        } else {
            completion(.failure(NetworkClientError.httpStatusCode(404)))
        }
    }
    
}
