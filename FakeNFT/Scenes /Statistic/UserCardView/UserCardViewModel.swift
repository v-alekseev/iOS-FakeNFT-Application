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
    @Published var isLoading = false
    @Published var loadError: String?
    
    var profileLikes: [String] = []
    private let dataProvider: StatisticDataProviderProtocol?
    
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
    
    init(dataProvider: StatisticDataProviderProtocol, userData: UserModel) {
        self.dataProvider = dataProvider
        actualUserData = userData
        loadProfileLikes()
    }
    
    func loadProfileLikes() {
        isLoading = true
        loadError = nil
        profileLikes = []
        dataProvider?.getProfileLikes() { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.profileLikes = data.likes
                case .failure(let error):
                    self.loadError = "\(error)"
                }
                self.isLoading = false
            }
        }
    }
}
