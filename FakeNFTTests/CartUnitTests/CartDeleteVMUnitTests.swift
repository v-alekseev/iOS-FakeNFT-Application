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


