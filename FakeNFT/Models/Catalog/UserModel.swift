//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts:  [String]
    let rating: String
    let id: String
}
