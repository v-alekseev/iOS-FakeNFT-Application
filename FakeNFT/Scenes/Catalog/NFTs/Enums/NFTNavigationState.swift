//
//  NFTNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 16.10.2023.
//

import Foundation
enum NFTNavigationState {
    case base
    case authorLinkDidTapped(url: URL)
    case NFTdidTapped(NFT: NFTModel)
    case basketDidTapped(at: IndexPath)
    case lokeDidTapped(at: IndexPath)
}
