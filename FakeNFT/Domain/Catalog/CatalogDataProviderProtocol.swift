//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 10.10.2023.
//

import Foundation

protocol CatalogDataProviderProtocol {
    func giveMeAllLikes() -> ProfileLikesModel?
    func setLikes(likes: [String])
    func fetchMeAllCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void)
    func giveMeCollection(withID id: String) -> CollectionModel?
    func giveMeAllNFTs() -> [NFTModel]
    func giveMeNft(withID id: String, completion: @escaping (Result<NFTModel, Error>) -> Void)
    func fetchMyAuthor(with id: String, completion: @escaping (Result<AuthorModel, Error>) -> Void)
}
