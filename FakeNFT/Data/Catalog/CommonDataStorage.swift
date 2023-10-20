//
//  CommonDataStorage.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

final class CommonDataStorage: CommonDataProtocol {
    
    static var shared: CommonDataStorage? = nil
    
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
        print("start init")
        self.dataProvider = dataProvider
        reloadCommonData()
    }
    
    static func initialize(with dataProvider: CatalogDataProviderProtocol = CatalogDataProvider()) {
        guard shared == nil else { return }
        shared = CommonDataStorage(with: dataProvider)
    }
    
    func isReady() -> Bool {
        return isDataLoaded
    }
    
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
    
    private func loadLikeData() {
        dataProvider.fetchMeLikes() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let likes):
                self.currentLikes = likes
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadOrders() {
        dataProvider.fetchMeOrders() {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let orders):
                self.currentOrder = orders
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func markReady() {
        self.isDataLoaded = true
        print("data ready")
        print(currentLikes ?? "nil")
        print(currentOrder ?? "nil")
        delegate?.notifyAboutLoadingState(isLoading: true)
    }
    
    private func markUnready() {
        print("data unready")
        self.delegate?.notifyAboutLoadingState(isLoading: false)
        self.currentOrder = nil
        self.currentLikes = nil
        self.isDataLoaded = false
    }
}
