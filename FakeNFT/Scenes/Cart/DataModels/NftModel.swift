//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

struct NftModel {
    let id: String
    let imageUrl: URL?
    let name: String
    let rating: Int
    let price: Double
    
    init(id: String, imageUrl: URL, name: String, rating: Int, price: Double) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.rating = rating
        self.price = price
    }
    
    init(nft: NftDto) {
        self.id = nft.id
        self.imageUrl = URL(string: nft.images.first ?? "")
        self.name = nft.name
        self.rating = nft.rating
        self.price = nft.price
    }
}

