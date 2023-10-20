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
    @Published var showStub = false
    
    var nftsIdForDisplayingLikes: [String]
    private let dataProvider: StatisticDataProviderProtocol?
    private var actualUserData: UserModel
    private var profileLikes: [String]
    
    init(dataProvider: StatisticDataProviderProtocol, actualUserData: UserModel, profileLikes: [String]) {
        
        self.dataProvider = dataProvider
        self.nfts = []
        self.nftsIdForDisplayingLikes = []
        self.profileLikes = profileLikes
        self.actualUserData = actualUserData
        loadNftsData()
    }
    
    func loadNftsData() {
        nfts = []
        nftsIdForDisplayingLikes = []
        showStub = false
        let dispatchGroup = DispatchGroup()
        actualUserData.nfts.forEach({ nft in
            dispatchGroup.enter()
            isLoading = true
            loadError = false
            dataProvider?.getNftWithId(nftId: nft) { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case let .success(data):
                        self.nfts.append(data)
                        if self.profileLikes.contains(data.id) {
                            self.nftsIdForDisplayingLikes.append(data.id)
                        }
                    case .failure(_):
                        self.loadError = true
                    }
                    dispatchGroup.leave()
                }
            }
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.isLoading = false
            self.nfts = self.nfts.sorted(by: {$0.name < $1.name})
            self.showStub = self.nfts.isEmpty ? true : false
        }
    }
}
