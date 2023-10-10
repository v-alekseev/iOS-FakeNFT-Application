//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

struct OrderDto: Codable {
    var nfts: [String]
    var id: String
}
