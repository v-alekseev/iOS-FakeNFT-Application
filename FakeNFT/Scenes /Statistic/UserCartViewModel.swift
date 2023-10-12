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
    
    private let dataProvider: StatisticDataProviderProtocol?
    
    init(dataProvider: StatisticDataProviderProtocol, userID: String) {
        self.actualUserData = UserModel(name: "",
                                        avatar: "",
                                        description: "",
                                        website: "",
                                        nfts: [""],
                                        rating: "",
                                        id: userID)
        self.dataProvider = dataProvider
        
        dataProvider.getActualUserData(id: userID) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.actualUserData = data
                case let .failure(error):
                    print (error)
                }
            }
        }
    }
}
