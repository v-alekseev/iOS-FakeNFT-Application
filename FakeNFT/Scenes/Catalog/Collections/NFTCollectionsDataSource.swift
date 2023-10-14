//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation

final class NFTCollectionsDataSource {
    private var collections: [CollectionModel]
    private var orderedCollections: [CollectionModel]
    private let dataProvider: CatalogDataProviderProtocol
    
    init(
        dataProvider: CatalogDataProviderProtocol,
        completion: @escaping (Result<[CollectionModel], Error>) -> Void = {_ in }
    ) {
        self.dataProvider = dataProvider
        self.collections = []
        self.orderedCollections = []
        self.dataProvider.giveMeAllCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                self.collections = collections
                self.orderedCollections = collections
                print("успешно \(collections)")
                completion(result)
            case .failure(let error):
                print(error)
                completion(result)
            }
            
        }
    }
    
    func giveMeAllCollections(isSorted: Bool = false) -> [CollectionModel] {
        return isSorted ? self.orderedCollections : self.collections
    }
    
    func howManyCollections() -> Int {
        return self.collections.count
    }
    
    func giveMeCollectionAt(index: Int, withSort: Bool = false) -> CollectionModel? {
        if index < self.collections.count {
            let base = withSort ? self.orderedCollections : self.collections
            return base[index]
        } else {
            return nil
        }
    }
    
    func reloadCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void = {_ in }) {
        self.dataProvider.giveMeAllCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                self.collections = collections
                self.orderedCollections = collections
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
    
    func sortCollectionsByName(inOrder: SortCases = .ascending ) {
        switch inOrder {
        case .ascending:
             self.orderedCollections = collections.sorted { $0.name < $1.name }
        case .descending:
            self.orderedCollections = collections.sorted { $0.name > $1.name }
        }
    }
    
    func sortCollectionsByNFTQuantity(inOrder: SortCases = .descending) {
        switch inOrder {
        case .ascending:
            self.orderedCollections =  collections.sorted { $0.nfts.count < $1.nfts.count }
        case .descending:
            self.orderedCollections =  collections.sorted { $0.nfts.count > $1.nfts.count }
        }
    }
    
}
