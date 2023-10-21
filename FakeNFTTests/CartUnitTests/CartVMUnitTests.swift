//
//  CartVMUnitTests.swift
//  FakeNFTTests
//
//  Created by Vitaly on 21.10.2023.
//

import Foundation
@testable import FakeNFT
import XCTest

final class CartVMUnitTests: XCTestCase {
    
    let cdp2 = MockCartDataProvider(getOrderResult: true)

    func testCartVMCreateDataProvide() {
        //given

        //when
        let vm = CartViewModel()
        //then
        XCTAssertTrue(vm.cartDataProvider != nil)
        XCTAssertTrue(ObjectIdentifier(vm.cartDataProvider! as! CardDataProvider) == ObjectIdentifier(CardDataProvider.shared))
    }
    
    func testCartVMCreateCustomDataProvide() {
        //given
        let cdp = MockCartDataProvider(removeItemFromCart: true)
        //when
        let vm = CartViewModel(dataProvider:  cdp)
        //then
        XCTAssertTrue(vm.cartDataProvider != nil)
        XCTAssertTrue(ObjectIdentifier(vm.cartDataProvider! as! MockCartDataProvider) == ObjectIdentifier(cdp))
    }
    
    func testCartVMgetOrder() {
        //given
        let vm = CartViewModel(dataProvider:  cdp2)
        vm.delegate = self
        //when
        vm.getOrder()
    }
    
}

extension CartVMUnitTests: CartViewModelDelegate {
    func didUpdateCart() {
        //then
        XCTAssertTrue(true)
        XCTAssertTrue(cdp2.order.count == 2)
    }
    
    func showAlert(message: String) {
        //then
        XCTAssertTrue(false)
    }
    
    func hideCartEvent(hide: Bool) {
        //then
        XCTAssertTrue(hide == false)
    }
    
    func willUpdateCart() {
        //then
        XCTAssertTrue(true)
    }
    
    
}
