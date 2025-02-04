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
    func howManyCollections() -> Int
    func getCollection(at indexPath: IndexPath) -> CollectionModel?
    func refresh(isPullRefresh: Bool)
    func bind(to controller: CollectionsViewController)
    func giveMeCollectionViewModel(for model: CollectionModel) -> CollectionViewModelProtocol
}

// MARK: - Extensions
extension CollectionsViewModelProtocol {
    func refresh() {
        refresh(isPullRefresh: false)
    }
}
