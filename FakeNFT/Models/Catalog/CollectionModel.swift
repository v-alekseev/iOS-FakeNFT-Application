//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//

import Foundation

struct CollectionModel: Codable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let id: String
    let author: String
}
