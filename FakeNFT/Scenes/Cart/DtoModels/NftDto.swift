//
//  NFTModel.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

struct NftDto: Codable {
    var createdAt: String
    var name: String
    var images : [String]
    var rating : Int
    var description : String
    var price : Double
    var author : String
    var id : String
    
    init(createdAt: String, name: String, images: [String], rating: Int, description: String, price: Double, author: String, id: String) {
        self.createdAt = createdAt
        self.name = name
        self.images = images
        self.rating = rating
        self.description = description
        self.price = price
        self.author = author
        self.id = id
    }
}
