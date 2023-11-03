//
//  CollectionResultState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 18.10.2023.
//

import Foundation

enum CollectionResultState {
    case start
    case loading(inProgress: Int)
    case showCollection
    case error(error: Error)
}
