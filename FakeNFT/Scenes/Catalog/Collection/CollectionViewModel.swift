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
        queue.maxConcurrentOperationCount = 2
        queue.isSuspended = true
        return queue
    }()
    
    private var dataSource: DataProviderInteractorProtocol
    private var model: CollectionModel
    
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
                print(self.resultState)
//                print("current NFTs count: \(self.dataSource.giveMeNFTsQuantity())")
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
        self.refresh()
    }
    
    func refresh() {
        self.dataSource.clearNFTs()
        self.dataSource.clearAuthor()
        self.refreshAuthor()
        self.refreshNFTs()
        self.startOperations()
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
            self.incrementLoading()
            let operation = BlockOperation { [weak self] in
                self?.dataSource.fetchMyNFT(with: id) { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
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
            Thread.sleep(forTimeInterval: 0.6)
        }
        self.operationQueue.addOperation(operation)
        self.operationQueue.addOperation(delayOperation)
    }
    
    private func startOperations() {
        operationQueue.isSuspended = false
    }
    
    private func handleLoadingState() {
        self.decrementLoading()
        switch self.resultState {
        case .error(let error):
            resultState = .error(error: error)
            break
        case .loading(let inProgress):
            if inProgress <= 0 {
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
            resultState = .loading(inProgress: 0)
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
        print("giveMeHeaderComponent")
        print("current collection: \(model)")
        print("current author: \(self.dataSource.giveMeCurrentAuthor())")
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
