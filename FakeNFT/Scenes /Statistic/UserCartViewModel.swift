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
    @Published var dataLoad: Bool
    @Published var possibleError: Error?
    
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
        possibleError = nil
        dataLoad = true
        
        dataProvider.getActualUserData(id: userID) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.actualUserData = data
                case let .failure(error):
                    self.possibleError = error
                    print(error)
                }
                self.dataLoad = false
            }
        }
    }
}
