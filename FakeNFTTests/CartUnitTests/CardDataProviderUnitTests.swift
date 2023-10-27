//
//  CardDataProviderUnitTests.swift
//  FakeNFTTests
//
//  Created by Vitaly on 21.10.2023.
//

import Foundation
import XCTest
@testable import FakeNFT


final class CardDataProviderUnitTests: XCTestCase {
    
    
    var mockNetworkClient = MockNetworkClient()
    var cartDataProvider = CardDataProvider.shared
    
    
    func testGetNFT() throws {
        //given
        let nftID = "93"
        cartDataProvider.networkClient = MockNetworkClient()
        //when
        cartDataProvider.getNFT(id: nftID) {  result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    //then
                    print("TEST OK \(data)")
                    XCTAssertTrue(data.id == nftID)
                    break
                case let .failure(error):
                    //then
                    print("TEST ERROR \(error)")
                    XCTAssertTrue(false)
                    break
                }
            }
        }
    }
    
    func testGetOrder() throws {
        //given
        cartDataProvider.networkClient = MockNetworkClient()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCartChaged(_:)),
                                               name: cartDataProvider.orderChanged,
                                               object: nil)
        
        //when
        cartDataProvider.getOrder() {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    //then
                    XCTAssertTrue(false)
                    break
                case let .failure(error):
                    //then
                    print("TEST ERROR \(error)")
                    XCTAssertTrue(false)
                    break
                }
            }
        }
    }
    
    @objc private func didCartChaged(_ notification: Notification) {
        //then
        print("cartDataProvider.order.first?.name = \(cartDataProvider.order.first?.name)")
        XCTAssertTrue(cartDataProvider.order.count == 2)
        XCTAssertTrue(cartDataProvider.order.first?.name ==  "Bitsy")
    }
}




