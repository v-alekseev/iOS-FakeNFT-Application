//
//  CollectionInteraction.swift
//  FakeNFT
//
//  Created by Александр Поляков on 18.10.2023.
//

import Foundation

enum CollectionInteraction {
    case authorLinkDidTapped
    case basketDidTapped(at: IndexPath)
    case likeDidTapped(at: IndexPath)
    case pop
}
