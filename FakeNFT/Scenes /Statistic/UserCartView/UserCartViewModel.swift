//
//  UserCartViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 12.10.2023.
//

import Foundation
import Combine

final class UserCartViewModel {
    
    @Published var actualUserData: UserModel
    @Published var isLoading = true
    @Published var needShowCollectionScreen = false
    @Published var needShowWebsite = false
    @Published var loadError = false
    
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
    
    private let dataProvider: StatisticDataProviderProtocol?
    
    init(dataProvider: StatisticDataProviderProtocol, userID: String) {
        self.dataProvider = dataProvider
        actualUserData = UserModel(name: "",
                                   avatar: "",
                                   description: "",
                                   website: "",
                                   nfts: [""],
                                   rating: "",
                                   id: userID)
        loadUserData()
    }
    
    func loadUserData() {
        loadError = false
        dataProvider?.getActualUserData(id: actualUserData.id) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.actualUserData = data
                case .failure(_):
                    self.loadError = true
                }
                self.isLoading = false
            }
        }
    }
}
