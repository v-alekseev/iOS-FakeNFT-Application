//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 16.10.2023.
//

import Foundation

final class CollectionViewModel: CollectionViewModelProtocol {
    
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
        print("refreshing")
        self.refreshAuthor()
        self.refreshNFTs()
    }
    
    private func refreshAuthor() {
        self.incrementLoading()
        self.dataSource.fetchMyAuthor(with: model.author) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                print("author success")
                self.handleLoadingState()
            case .failure(let error):
                print(error)
                self.resultState = .error(error: error)
            }
        }
    }
    
    private func refreshNFTs() {
        self.model.nfts.forEach { id in
            self.incrementLoading()
            self.dataSource.fetchMyNFT(with: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    print("nft success")
                    self.handleLoadingState()
                case .failure(let error):
                    print(error)
                    self.resultState = .error(error: error)
                }
            }
        }
    }
    
    private func handleLoadingState() {
        self.decrementLoading()
        switch self.resultState {
        case .loading(let inProgress):
            if inProgress == 0 {
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
        switch resultState {
        case .loading(let inProgress):
            if inProgress <= 0 {
                resultState = .showCollection
            } else {
                resultState = .loading(inProgress: inProgress - 1)
            }
        default:
            break
        }
    }
    
    func handleInteractionType(_ type: CollectionInteraction) {
        return
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
