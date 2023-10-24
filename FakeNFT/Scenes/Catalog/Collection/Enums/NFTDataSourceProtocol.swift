//
//  NFTDataSourceProtocol.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

protocol NFTDataSourceProtocol {
    func numberOfNFTs() -> Int
    func nft(at indexPath: IndexPath) -> NFTModel?
    func isNFTLiked(at indexPath: IndexPath) -> Bool
    func isNFTOrdered(at indexPath: IndexPath) -> Bool
    func interactWithLike(itemId: String)
    func interactWithBasket(itemId: String)
}
