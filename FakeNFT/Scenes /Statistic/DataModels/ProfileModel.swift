//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 20.10.2023.
//

import Foundation

struct ProfileModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
