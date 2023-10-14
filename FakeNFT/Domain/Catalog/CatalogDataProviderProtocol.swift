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
    func giveMeAllCollections() -> [CollectionModel]
    func giveMeCollection(withID id: String) -> CollectionModel?
    func giveMeAllNFTs() -> [NFTModel]
    func giveMeNft(withID id: String) -> NFTModel?
}
