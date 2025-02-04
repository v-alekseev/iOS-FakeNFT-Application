//
//  CommonDataProtocol.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

protocol CommonDataProtocol {
    func reloadCommonData(asap: Bool)
    func isReady() -> Bool
    func isNFTLiked(id: String) -> Bool
    func isNFTOrderd(id: String) -> Bool
    func setDelegate(delegate: StorageDelegate)
    func clearDelegate()
    func interactWithLike(with NFTid: String, completion: @escaping (Result <ProfileLikesModel, Error>) -> Void)
    func interactWithBasket(with NFTid: String, completion: @escaping (Result<OrderModel, Error>) -> Void)
}

extension CommonDataProtocol {
    func reloadCommonData() {
        reloadCommonData(asap: false)
    }
}
