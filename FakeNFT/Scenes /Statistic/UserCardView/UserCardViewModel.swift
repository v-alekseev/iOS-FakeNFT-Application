//
//  UserCardViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 12.10.2023.
//

import Foundation
import Combine

final class UserCardViewModel {
    
    @Published var actualUserData: UserModel
    @Published var needShowCollectionScreen = false
    @Published var needShowWebsite = false
    
    var didTapCollectionButton = false {
        didSet { if didTapCollectionButton {
            needShowCollectionScreen = true
            didTapCollectionButton = false}
        }
    }
    
    var didTapWebsiteButton = false {
        didSet { if didTapWebsiteButton {
            needShowWebsite = true
            didTapWebsiteButton = false}
        }
    }
    
    init(userData: UserModel) {
        actualUserData = userData
    }
}
