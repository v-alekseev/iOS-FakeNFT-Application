//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
final class CollectionsViewModel: CollectionsViewModelProtocol {
  
    var navigationClosure: (CollectionsNavigationState) -> Void = {_ in }
    private (set) var navigationState: CollectionsNavigationState = .base {
        didSet(newValue) {
            navigationClosure(newValue)
        }
    }
    
    var resultClosure: (CollectionsResultState) -> Void = {_ in }
    private (set) var resultState: CollectionsResultState = .start {
        didSet(newValue) {
            resultClosure(newValue)
        }
    }
    
    
    func setSortType(sortType: SortType) {
        print("ok")
    }
    
    func howManyCollections() -> Int {
        return 0
    }
    
    func getCollection(at indexPath: IndexPath) -> CollectionModel? {
        return nil
    }
    
    func getCollectionName(at indexPath: IndexPath) -> String {
        return ""
    }
    
    func getCollectionImage(at indexPath: IndexPath) -> String {
        return ""
    }
    
    func getCollectionNFTQuantity(at indexPath: IndexPath) -> Int {
        return 0
    }
    
    func handleNavigation(action: CollectionNavigationAction) {
        switch action {
        case .collectionDidTapped(let collection):
            print("VM collection didTapped")
            navigationState = .base
        case .pullToRefresh:
            print("VM pullToRefresh")
            navigationState = .base
        case .sorterDidTapped:
            navigationState = .sortSelection
        case .sortDidSelected(let which):
            print("VM sort did selected")
            navigationState = .base
        case .sortIsCancelled:
            print("VM sort is cancelled")
            navigationState = .base
        }
    }
}
