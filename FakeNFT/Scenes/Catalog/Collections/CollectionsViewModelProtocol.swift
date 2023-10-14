//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
protocol CollectionsViewModelProtocol {
    var navigationClosure: ((CollectionsNavigationState) -> Void) { get set }
    var resultClosure: ((CollectionsResultState) -> Void) { get set }
    func handleNavigation(action: CollectionNavigationAction)
    func setSortType(sortType: SortType)
    func howManyCollections() -> Int
    func getCollection(at indexPath: IndexPath) -> CollectionModel?
    func getCollectionName(at indexPath: IndexPath) -> String
    func getCollectionImage(at indexPath: IndexPath) -> String
    func getCollectionNFTQuantity(at indexPath: IndexPath) -> Int
    func refresh(isPullRefresh: Bool)
}

extension CollectionsViewModelProtocol {
    func refresh() {
        refresh(isPullRefresh: false)
    }
}
