//
//  CommonDataStorage.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

final class CommonDataStorage: CommonDataProtocol {
    
    static var shared: CommonDataStorage? = nil
    private let cartDataProvider = CardDataProvider.shared

    
    // MARK: - Private properties
    private var isDataLoaded: Bool = false {
        didSet {
            delegate?.notifyAboutLoadingState(isLoading:isDataLoaded)
        }
    }
    private var currentOrder: OrderModel?
    private var currentLikes: ProfileLikesModel?
    private var delegate: StorageDelegate?
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
        queue.isSuspended = true
        return queue
    }()
    
    private var dataProvider: CatalogDataProviderProtocol
    
    private init(with dataProvider: CatalogDataProviderProtocol = CatalogDataProvider()) {
        self.dataProvider = dataProvider
        reloadCommonData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didCartChaged),
            name: self.cartDataProvider.orderChanged,
            object: nil
        )
    }
    
    @objc
    private func didCartChaged() {
        var update1: [String] = []
        var update2: [String] = []
        if let currentNfts = currentOrder?.nfts {
            update1 = cartDataProvider.orderIDs.filter {!currentNfts.contains($0)}
            update2 = currentNfts.filter {!cartDataProvider.orderIDs.contains($0)}
        }
        currentOrder?.nfts = cartDataProvider.orderIDs
        guard let currentOrder = currentOrder else { return }
        var dataToUpdate = currentOrder
        dataToUpdate.nfts = update1 + update2
        delegate?.notifiAboutOrdersCnahges(order: dataToUpdate)
    }
    
    // MARK: - Initialize
    static func initialize(with dataProvider: CatalogDataProviderProtocol = CatalogDataProvider()) {
        guard shared == nil else { return }
        shared = CommonDataStorage(with: dataProvider)
    }
    
    func isReady() -> Bool {
        return isDataLoaded
    }
    
    // MARK: - RELOAD
    func reloadCommonData(asap: Bool) {
        queue.cancelAllOperations()
        switch asap {
        case true:
            queue.qualityOfService = .userInitiated
        default:
            queue.qualityOfService = .background
        }
        queue.isSuspended = true
        self.markUnready()
        queue.addOperation(loadLikeData, withDelay: 1)
        queue.addOperation(loadOrders, withDelay: 1)
        queue.addOperation {[weak self] in
            self?.markReady()
        }
        queue.isSuspended = false
    }
    
    func isNFTLiked(id: String) -> Bool {
        return currentLikes?.likes.contains(id) ?? false
    }
    
    func isNFTOrderd(id: String) -> Bool {
        return currentOrder?.nfts.contains(id) ?? false
    }
    
    func setDelegate(delegate: StorageDelegate) {
        self.delegate = delegate
    }
    
    func clearDelegate() {
        self.delegate = nil
    }
    
    private func loadLikeData() {
        dataProvider.fetchMeLikes() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let likes):
                self.currentLikes = likes
            case .failure:
                break
            }
        }
    }
    
    private func loadOrders() {
        dataProvider.fetchMeOrders() {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let orders):
                self.currentOrder = orders
            case .failure:
                break
            }
        }
    }
    
    private func markReady() {
        self.isDataLoaded = true
        delegate?.notifyAboutLoadingState(isLoading: true)
    }
    
    private func markUnready() {
        self.delegate?.notifyAboutLoadingState(isLoading: false)
        self.currentOrder = nil
        self.currentLikes = nil
        self.isDataLoaded = false
    }
    
    // MARK: - Interact
    func interactWithLike(with NFTid: String, completion: @escaping (Result<ProfileLikesModel, Error>) -> Void) {
        guard var likes = currentLikes else { return }
        likes.likes.contains(NFTid) ? likes.likes.removeAll(where: {$0 == NFTid}) : likes.likes.append(NFTid)
        dataProvider.setLikes(likes: likes.likes) {[weak self] result in
            switch result {
            case .success(let likes):
                self?.currentLikes = likes
            case .failure:
                break
            }
            completion(result)
        }
    }
    
    func interactWithBasket(with NFTid: String, completion: @escaping (Result<OrderModel, Error>) -> Void) {
        guard var orders = currentOrder else { return }
        orders.nfts.contains(NFTid) ? orders.nfts.removeAll(where: {$0 == NFTid}) : orders.nfts.append(NFTid)
        dataProvider.setOrders(orders: orders) {[weak self] result in
            switch result {
            case .success(let orders):
                self?.currentOrder = orders
            case .failure:
                break
            }
            completion(result)
        }
    }
}
