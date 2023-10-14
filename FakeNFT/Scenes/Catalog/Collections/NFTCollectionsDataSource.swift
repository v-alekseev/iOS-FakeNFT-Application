//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation

class NFTCollectionsDataSource {
    private var collections: [CollectionModel]
    private let dataProvider: CatalogDataProviderProtocol
    
    init(
        dataProvider: CatalogDataProviderProtocol,
        completion: @escaping (Result<[CollectionModel], Error>) -> Void = {_ in }
    ) {
        self.dataProvider = dataProvider
        self.collections = []
        self.dataProvider.giveMeAllCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                self.collections = collections
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
    
    func giveMeAllCollections() -> [CollectionModel] {
        return self.collections
    }
    
    func reloadCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void = {_ in }) {
        self.dataProvider.giveMeAllCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                self.collections = collections
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
    
    func sortCollectionsByName(inOrder: SortCases = .ascending ) -> [CollectionModel] {
        switch inOrder {
        case .ascending:
            return collections.sorted { $0.name < $1.name }
        case .descending:
            return collections.sorted { $0.name > $1.name }
        }
    }
    
    func sortCollectionsByNFTQuantity(inOrder: SortCases = .ascending) -> [CollectionModel] {
        switch inOrder {
        case .ascending:
            return collections.sorted { $0.nfts.count < $1.nfts.count }
        case .descending:
            return collections.sorted { $0.nfts.count > $1.nfts.count }
        }
    }
    
}
