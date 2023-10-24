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
    func clearAuthor()
    func fetchMyAuthor(with id: String, completion: @escaping (Result<AuthorModel, Error>) -> Void)
    func clearNFTs()
    func fetchMyNFT(with id: String, completion: @escaping (Result<NFTModel, Error>) -> Void)
    func giveMeCurrentAuthor() -> AuthorModel?
    func giveMeNFTsQuantity() -> Int
    func giveMeNFTAt(index: Int) -> NFTModel?
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
