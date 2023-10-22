//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 10.10.2023.
//

import Foundation

protocol CatalogDataProviderProtocol {
    func fetchMeLikes(completion: @escaping (Result<ProfileLikesModel, Error>) -> Void)
    func fetchMeOrders(completion: @escaping (Result<OrderModel, Error>) -> Void)
    func setLikes(likes: [String], completion: @escaping (Result<ProfileLikesModel, Error>) -> Void)
    func setOrders(orders: OrderModel, completion: @escaping (Result<OrderModel, Error>) -> Void)
    func fetchMeAllCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void)
    func giveMeCollection(withID id: String) -> CollectionModel?
    func giveMeAllNFTs() -> [NFTModel]
    func fetchMeNft(withID id: String, completion: @escaping (Result<NFTModel, Error>) -> Void)
    func fetchMyAuthor(with id: String, completion: @escaping (Result<AuthorModel, Error>) -> Void)
}
