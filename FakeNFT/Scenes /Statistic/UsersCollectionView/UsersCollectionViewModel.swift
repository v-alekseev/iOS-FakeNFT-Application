//
//  UsersCollectionViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 18.10.2023.
//

import Foundation
import Combine

final class UsersCollectionViewModel {
    
    @Published var nfts: [NftModel]
    @Published var isLoading = false
    @Published var loadError = false
    
    private var actualUserData: UserModel
    private let dataProvider: StatisticDataProviderProtocol?

    init(dataProvider: StatisticDataProviderProtocol, actualUserData: UserModel) {
        
        self.dataProvider = dataProvider
        self.nfts = []
        self.actualUserData = actualUserData
        loadNftsData()
    }
    
    func loadNftsData() {
        isLoading = true
        loadError = false
        dataProvider?.getArrayOfNftsWithID(arrayOfId: actualUserData.nfts) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.nfts = data
                case .failure(_):
                    self.loadError = true
                }
                self.isLoading = false
            }
        }
    }
}
