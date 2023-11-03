//
//  CurrenciesDto.swift
//  FakeNFT
//
//  Created by Vitaly on 19.10.2023.
//

import Foundation


struct CurrencyDto: Codable {
    var title: String
    var name: String
    var image: String
    var id: String
    
    init(_ dto: CurrencyDto) {
        self.title = dto.title
        self.name = dto.name
        self.image = dto.image
        self.id = dto.id
    }
}


struct PaymentDto: Codable {
    var success: Bool
    var id: String
    var orderId: String
}
