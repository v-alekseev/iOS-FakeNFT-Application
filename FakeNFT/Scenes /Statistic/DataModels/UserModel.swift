//
//  UserModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 11.10.2023.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}
