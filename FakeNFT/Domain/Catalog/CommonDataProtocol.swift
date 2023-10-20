//
//  CommonDataProtocol.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

protocol CommonDataProtocol {
    func reloadCommonData()
    func isReady() -> Bool
    func isNFTLiked(id: String) -> Bool
    func isNFTOrderd(id: String) -> Bool
    func setDelegate(delegate: StorageDelegate)
}
