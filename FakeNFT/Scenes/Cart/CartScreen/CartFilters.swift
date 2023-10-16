//
//  Filters.swift
//  FakeNFT
//
//  Created by Vitaly on 16.10.2023.
//

import Foundation

class Filters {
    typealias FilterClosure =  (NftModel, NftModel) -> Bool
    
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
