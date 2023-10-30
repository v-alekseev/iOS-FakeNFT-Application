//
//  MockCollectionsViewModel.swift
//  FakeNFTTests
//
//  Created by Александр Поляков on 14.10.2023.
//

import Foundation
@testable import FakeNFT
import XCTest

class MockCollectionsViewModel: CollectionsViewModelProtocol {
    func giveMeCollectionViewModel(for model: FakeNFT.CollectionModel) -> FakeNFT.CollectionViewModelProtocol {
        return CollectionViewModel(
            dataSource: DataProviderInteractor(
                dataProvider: CatalogDataProvider(
                    client: MockNetworkClient()
                )
            ),
            model: CollectionModel(
                createdAt: "1",
                name: "2",
                cover: "3",
                nfts: ["4"],
                description: "5",
                id: "6",
                author: "7"
            )
        )
    }
    
    
    enum MockError: Error {
        case someError
    }
    
    func refresh(isPullRefresh: Bool = false) {
        resultClosure(.error(MockError.someError))
    }
    
    var navigationClosure: ((FakeNFT.CollectionsNavigationState) -> Void) = {_ in}
    
    var resultClosure: ((FakeNFT.CollectionsResultState) -> Void) = {_ in}
    
    func handleNavigation(action: FakeNFT.CollectionNavigationAction) {
    }
    
    func howManyCollections() -> Int {
        return 0
    }
    
    func getCollection(at indexPath: IndexPath) -> FakeNFT.CollectionModel? {
        return nil
    }
    
    func bind(to controller: CollectionsViewController) {
        // Ничего не делаем, чтобы не переопределять замыкания
    }
}
