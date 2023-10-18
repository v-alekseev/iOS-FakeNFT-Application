//
//  DataProviderInteractorProtocol.swift
//  FakeNFT
//
//  Created by Александр Поляков on 17.10.2023.
//

import Foundation
protocol DataProviderInteractorProtocol {
    func giveMeAllCollections(isSorted: Bool) -> [CollectionModel]
    func howManyCollections() -> Int
    func giveMeCollectionAt(index: Int, withSort: Bool) -> CollectionModel?
    func reloadCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void)
    func sortCollectionsByName(inOrder: SortCases)
    func sortCollectionsByNFTQuantity(inOrder: SortCases)
}

extension DataProviderInteractorProtocol {
    func giveMeAllCollections() -> [CollectionModel] {
        return giveMeAllCollections(isSorted: false)
    }
    
    func giveMeCollectionAt(index: Int) -> CollectionModel? {
        return giveMeCollectionAt(index: index, withSort: false)
    }
    
    func reloadCollections() {
        reloadCollections(completion: {_ in })
    }
    
    func sortCollectionsByName() {
        sortCollectionsByName(inOrder: .ascending)
    }
    
    func sortCollectionsByNFTQuantity() {
        sortCollectionsByNFTQuantity(inOrder: .descending)
    }
}
