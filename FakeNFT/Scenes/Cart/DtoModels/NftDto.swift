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
}
