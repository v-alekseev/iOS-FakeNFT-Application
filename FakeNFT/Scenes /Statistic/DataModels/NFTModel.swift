//
//  NFTModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 11.10.2023.
//

import Foundation

struct NFTModel: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: UserModel
    let id: String
}
