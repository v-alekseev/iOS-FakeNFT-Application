//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
final class CollectionsViewModel: CollectionsViewModelProtocol {
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
    
    
}
