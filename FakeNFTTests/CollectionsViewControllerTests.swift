//
//  CollectionsViewControllerTests.swift
//  FakeNFTTests
//
//  Created by Александр Поляков on 14.10.2023.
//

import XCTest
@testable import FakeNFT

class CollectionsViewControllerTests: XCTestCase {
    var viewController: CollectionsViewController!
    var mockViewModel: MockCollectionsViewModel!

    override func setUpWithError() throws {
        mockViewModel = MockCollectionsViewModel()
        viewController = CollectionsViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        mockViewModel = nil
    }

    func testViewModelReturnsError() {
        let expectation = self.expectation(description: "Ожидаем получение ошибки")
        
        mockViewModel.resultClosure = { state in
            if case .error = state {
                expectation.fulfill()
            }
        }
        
        viewController.viewDidLoad()
        
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("Время вышло: \(error)")
            }
        }
    }
}

