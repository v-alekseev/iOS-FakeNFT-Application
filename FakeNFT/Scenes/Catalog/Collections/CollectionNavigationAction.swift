//
//  CollectionNavigationAction.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import Foundation

enum CollectionNavigationAction {
    case sortingDidTapped
    case sortDidSelected(which: SortType)
    case sortIsCancelled
    case pullToRefresh
    case collectionDidTapped(collection: CollectionModel)
}
