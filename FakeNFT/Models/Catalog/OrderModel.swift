//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

struct OrderModel: Codable {
    var nfts: [String]
    let id: String
}
