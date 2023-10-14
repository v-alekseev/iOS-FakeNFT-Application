//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
enum SortType {
    
    case byName(order: SortCases)
    case byNFTQuantity(order: SortCases)
    
    var title: String {
        switch self {
        case .byName:
            return L10n.Catalog.Sort.byName
        case .byNFTQuantity:
            return L10n.Catalog.Sort.byNFTQuantity
        }
    }
}
