//
//  Filters.swift
//  FakeNFT
//
//  Created by Vitaly on 16.10.2023.
//

import Foundation

struct Filters {
    typealias FilterClosure =  (NftModel, NftModel) -> Bool
    // filterBy нужен только для того, что бы в UserData сохранять Closure
    enum filterBy: Int {
        case id
        case name
        case price
        case rating
    }
    
    static let filter: [filterBy:FilterClosure] = [.id: filterDefault,
                                            .name: filterByName,
                                            .price: filterByPrice,
                                            .rating: filterByRating
    ]
    
    static var filterDefault: FilterClosure = {a , b in
        return a.id < b.id
    }
    static var filterByName: FilterClosure = {a , b in
        return a.name < b.name
    }
    static var filterByPrice: FilterClosure = {a , b in
        return a.price < b.price
    }
    static var filterByRating: FilterClosure = {a , b in
        return a.rating > b.rating
    }
}
