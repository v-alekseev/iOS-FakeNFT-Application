//
//  CollectionsResultState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import Foundation
enum CollectionsResultState {
    case start
    case loading
    case show
    case error(Error)
}
