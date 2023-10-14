//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import Foundation
enum CollectionsNavigationState {
    case sort(type: SortType)
    case collectionDetails(collection: CollectionModel)
}
