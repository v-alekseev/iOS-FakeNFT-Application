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
            navigationClosure(navigationState)
        }
    }
    
    var resultClosure: (CollectionResultState) -> Void = {_ in }
    private (set) var resultState: CollectionResultState = .start {
        didSet {
            resultClosure(resultState)
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
    }
    
    private func refreshAuthor() {
        self.dataSource.fetchMyAuthor(with: model.author) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.handleLoadingState()
            case .failure(let error):
                print(error)
                self.resultState = .error(error: error)
            }
        }
    }
    
    private func refreshNFTs() {
        self.model.nfts.forEach { id in
            self.dataSource.fetchMyNFT(with: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
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
            resultState = .loading(inProgress: inProgress + 1)
        default:
            resultState = .loading(inProgress: 0)
        }
    }
    
    private func decrementLoading() {
        switch resultState {
        case .loading(let inProgress):
            resultState = .loading(inProgress: inProgress - 1)
        default:
            break
        }
    }
    
    func handleInteractionType(_ type: CollectionInteraction) {
        return
    }
    
    func giveMeHeaderComponent() -> (collection: CollectionModel, author: AuthorModel) {
        return (
            collection: model,
            author: AuthorModel(
                name: "Aleksandr Poliakov",
                avatar: "2",
                description: "dsfasfkab",
                website: "https://yandex.ru/",
                nfts: [],
                rating: "1",
                id: "1"
            )
        )
    }
}
