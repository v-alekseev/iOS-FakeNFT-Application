//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 16.10.2023.
//

import Foundation

final class CollectionViewModel: CollectionViewModelProtocol {

    
    
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.isSuspended = true
        return queue
    }()
    
    let commonStorage = CommonDataStorage.shared
    
    private var dataSource: DataProviderInteractorProtocol
    private var model: CollectionModel
    private var isBackgroundDataLoaded: Bool = false {
        didSet {
            switch isBackgroundDataLoaded {
            case false:
                switch resultState {
                case .showCollection:
                    resultState = .loading(inProgress: 0)
                default:
                    break
                }
            default:
                handleLoadingState()
            }
        }
    }
    
    var navigationClosure: (CollectionNavigationState) -> Void = {_ in }
    private (set) var navigationState: CollectionNavigationState = .base {
        didSet {
            print(navigationState)
            navigationClosure(navigationState)
        }
    }
    
    var resultClosure: (CollectionResultState) -> Void = {_ in }
    private (set) var resultState: CollectionResultState = .start {
        didSet {
            DispatchQueue.main.async { [self] in
                resultClosure(self.resultState)
            }
        }
    }
    
    init(
        dataSource: DataProviderInteractorProtocol,
        model: CollectionModel
    ) {
        self.dataSource = dataSource
        self.model = model
        if let storage = self.commonStorage {
            storage.setDelegate(delegate: self)
            self.isBackgroundDataLoaded = storage.isReady()
        }
        self.refresh()
    }
    
    func refresh(withCommonData: Bool) {
        if (withCommonData) {
            self.isBackgroundDataLoaded = false
            self.commonStorage?.reloadCommonData()
        } else {
            if let store = self.commonStorage {
                self.isBackgroundDataLoaded = store.isReady()
            }
        }
        self.operationQueue.cancelAllOperations()
        self.dataSource.clearNFTs()
        self.dataSource.clearAuthor()
        self.refreshAuthor()
        self.refreshNFTs()
        self.startOperations()
    }
    
    func clearLinks() {
        self.dataSource.clearNFTs()
        self.dataSource.clearNFTs()
        self.commonStorage?.clearDelegate()
        self.operationQueue.cancelAllOperations()
    }
    
    private func refreshAuthor() {
        self.incrementLoading()
        let operation = BlockOperation { [weak self] in
            guard let self = self else { return }
            self.dataSource.fetchMyAuthor(with: self.model.author) {[weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.decrementLoading()
                        self.handleLoadingState()
                    case .failure(let error):
                        self.resultState = .error(error: error)
                    }
                }
            }
        }
        addOperationWithDelay(operation)
    }
    
    private func refreshNFTs() {
        for id in model.nfts {
            print("отправляю задачу на сборку NFT с id: \(id)")
            self.incrementLoading()
            let operation = BlockOperation { [weak self] in
                self?.dataSource.fetchMyNFT(with: id) { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            self.decrementLoading()
                            self.handleLoadingState()
                        case .failure(let error):
                            self.resultState = .error(error: error)
                        }
                    }
                }
            }
            addOperationWithDelay(operation)
        }
    }
    
    private func addOperationWithDelay(_ operation: Operation) {
        let delayOperation = BlockOperation {
            Thread.sleep(forTimeInterval: 0.5)
        }
        self.operationQueue.addOperation(operation)
        self.operationQueue.addOperation(delayOperation)
    }
    
    private func startOperations() {
        operationQueue.isSuspended = false
    }
    
    private func handleLoadingState() {
        switch self.resultState {
        case .error(let error):
            resultState = .error(error: error)
            break
        case .loading(let inProgress):
            if inProgress <= 0 && self.isBackgroundDataLoaded {
                self.resultState = .showCollection
            }
        default:
            break
        }
    }
    
    private func incrementLoading() {
        switch resultState {
        case .loading(let inProgress):
            if inProgress <= 0 {
                resultState = .loading(inProgress: 1)
            } else {
                resultState = .loading(inProgress: inProgress + 1)
            }
        default:
            resultState = .loading(inProgress: 1)
        }
    }
    
    private func decrementLoading() {
        switch self.resultState {
        case .loading(let inProgress):
            self.resultState = .loading(inProgress: inProgress - 1)
        default:
            break
        }
    }
    
    func handleInteractionType(_ type: CollectionInteraction) {
        self.navigationState = .backButtonTapped
    }
    
    func giveMeHeaderComponent() -> (collection: CollectionModel, author: AuthorModel?) {
        return (
            collection: model,
            author: self.dataSource.giveMeCurrentAuthor()
        )
    }
    
    // MARK: - Binding
    func bind(to controller: CollectionViewController) {
        self.navigationClosure = {[weak controller] state in
            guard let controller = controller else { return }
            controller.renderState(state: state)
        }

        self.resultClosure = {[weak controller] state in
            guard let controller = controller else { return }
            controller.renderState(state: state)
        }
    }
}

extension CollectionViewModel: StorageDelegate {
    func notifyAboutLoadingState(isLoading: Bool) {
        self.isBackgroundDataLoaded = isLoading
    }
}

extension CollectionViewModel: NFTDataSourceProtocol {
    func numberOfNFTs() -> Int {
        return model.nfts.count
    }
    
    func nft(at indexPath: IndexPath) -> NFTModel? {
        let row = indexPath.row
        if (row > self.numberOfNFTs() - 1) {
            print("я вьюмодель")
            print("Возвращаю nil")
            print("row = \(row)")
            print("numberOfNFTs = \(self.numberOfNFTs())")
            return nil
        } else {
            return dataSource.giveMeNFTAt(index: row)
        }
    }
    
    func isNFTLiked(at indexPath: IndexPath) -> Bool {
        let row = indexPath.row
        if (row > self.numberOfNFTs() - 1) {
            return false
        } else {
            let id = self.model.nfts[row]
            guard let store = commonStorage else { return false }
            return store.isNFTLiked(id: id)
        }
    }
    
    func isNFTOrdered(at indexPath: IndexPath) -> Bool {
        let row = indexPath.row
        if (row > self.numberOfNFTs() - 1) {
            return false
        } else {
            let id = self.model.nfts[row]
            guard let store = commonStorage else { return false }
            return store.isNFTOrderd(id: id)
        }
    }
}
