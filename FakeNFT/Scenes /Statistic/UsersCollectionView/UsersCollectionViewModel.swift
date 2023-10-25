//
//  UsersCollectionViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 18.10.2023.
//

import Foundation
import Combine

final class UsersCollectionViewModel {
    
    @Published var nfts: [NftModel] = []
    @Published var nftsInCartId: [String] = []
    @Published var isLoading = false
    @Published var loadError: String?
    @Published var showStub = false
    
    var nftsIdForDisplayingLikes: [String] = []
    private let dataProvider: StatisticDataProviderProtocol?
    private var handlingErrorService = HandlingErrorService.shared
    private var actualUserData: UserModel
    private var profileLikes: [String]
    
    init(dataProvider: StatisticDataProviderProtocol, actualUserData: UserModel, profileLikes: [String]) {
        self.dataProvider = dataProvider
        self.actualUserData = actualUserData
        self.profileLikes = profileLikes
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
            loadError = nil
            dataProvider?.getNftWithId(nftId: nft) { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case let .success(data):
                        self.nfts.append(data)
                        if self.profileLikes.contains(data.id) {
                            self.nftsIdForDisplayingLikes.append(data.id)
                        }
                    case .failure(let error):
                        let errorString = self.handlingErrorService.handlingHTTPStatusCodeError(error: error)
                        self.loadError = errorString
                    }
                    dispatchGroup.leave()
                }
            }
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.isLoading = false
            self.nfts = self.nfts.sorted(by: {$0.name < $1.name})
            self.showStub = self.nfts.isEmpty ? true : false
            self.loadCartId()
        }
    }
    
    func changeCartState (nftId: String, isInCart: Bool) {
        if isInCart {
            removeNftsWithIdFromCart(id: nftId)
        }
        else {
            addNftsWithIdToCart(id: nftId)
        }
    }
    
    func removeNftsWithIdFromCart (id: String) {
        let newNftsInCartId = nftsInCartId.filter(){$0 != id}
        cartUpdate(newNftsInCartId)
    }
    
    func addNftsWithIdToCart (id: String) {
        var newNftsInCartId = nftsInCartId
        newNftsInCartId.append(id)
        cartUpdate(newNftsInCartId)
    }
    
    private func loadCartId() {
        isLoading = true
        loadError = nil
        dataProvider?.getIdNftsInCard() { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.nftsInCartId = data.nfts
                case .failure(let error):
                    let errorString = self.handlingErrorService.handlingHTTPStatusCodeError(error: error)
                    self.loadError = errorString
                }
                self.isLoading = false
            }
        }
    }
    
    private func cartUpdate (_ newNftsInCartId: [String]) {
        isLoading = true
        loadError = nil
        dataProvider?.cartUpdate(newCartIDs: newNftsInCartId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.nftsInCartId = data.nfts
                case .failure(let error):
                    let errorString = self.handlingErrorService.handlingHTTPStatusCodeError(error: error)
                    self.loadError = errorString
                }
                self.isLoading = false
            }
        }
    }
}
