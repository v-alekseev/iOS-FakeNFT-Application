//
//  AuthorModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 18.10.2023.
//

import Foundation

struct AuthorModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}
