//
//  NFTInteraction.swift
//  FakeNFT
//
//  Created by Александр Поляков on 18.10.2023.
//

import Foundation

enum NFTInteraction {
    case authorLinkDidTapped
    case basketDidTapped(at: IndexPath)
    case likeDidTapped(at: IndexPath)
}
