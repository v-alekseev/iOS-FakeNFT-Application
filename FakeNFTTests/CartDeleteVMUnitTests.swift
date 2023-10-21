//
//  CartDeleteVMUnitTests.swift
//  FakeNFTTests
//
//  Created by Vitaly on 21.10.2023.
//

import Foundation
@testable import FakeNFT
import XCTest

final class CartDeleteVMUnitTests: XCTestCase {

// 2. Тесты ViewModel  с моками DataModel
    // CartDeleteViewModel

    func testCartDeleteVMCreateDefaultDataProvide() {
        //given
        let id = "1"
        let nftImage = UIImage(resource: .nfTcard)
        //when
        let vm = CartDeleteViewModel(nftImage: nftImage, nftIDforDelete: id)
        //then
        XCTAssertTrue(vm.dataProvider != nil)
        XCTAssertTrue(ObjectIdentifier(vm.dataProvider! as! CardDataProvider) == ObjectIdentifier(CardDataProvider.shared))
    }
    
    func testCartDeleteVMCreateCustomDataProvide() {
        //given
        let id = "1"
        let nftImage = UIImage(resource: .nfTcard)
        let cdp = MockCartDataProvider(removeItemFromCart: true)
        //when
        let vm = CartDeleteViewModel(nftImage: nftImage, nftIDforDelete: id, dataProvider:  cdp)
        //then
        XCTAssertTrue(vm.dataProvider != nil)
        XCTAssertTrue(ObjectIdentifier(vm.dataProvider! as! MockCartDataProvider) == ObjectIdentifier(cdp))
    }
    
    func testCartDeleteVMremoveItemFromCartSuccess() {
        //given
        let id = "1"
        let nftImage = UIImage(resource: .nfTcard)
        let cdp = MockCartDataProvider(removeItemFromCart: true)
        //when
        let vm = CartDeleteViewModel(nftImage: nftImage, nftIDforDelete: id, dataProvider:  cdp)
        //then
        vm.deleteNFT() { result in
            switch result {
            case let .success(data):
                XCTAssertTrue(data == ["1","2"])
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testCartDeleteVMremoveItemFromCartFailure() {
        //given
        let id = "1"
        let nftImage = UIImage(resource: .nfTcard)
        let cdp = MockCartDataProvider(removeItemFromCart:  false)
        //when
        let vm = CartDeleteViewModel(nftImage: nftImage, nftIDforDelete: id, dataProvider:  cdp)
        //then
        vm.deleteNFT() { result in
            switch result {
            case .success(_):
                XCTAssertTrue(false)
            case .failure(_):
                XCTAssertTrue(true)
            }
        }
    }
    
    
}

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

