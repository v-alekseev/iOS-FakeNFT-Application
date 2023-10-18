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
        self.dataSource.fetchMyAuthor(with: model.author) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let author):
                self.resultState = .showCollection(collection: self.model, author: author)
            case .failure(let error):
                print(error)
                self.resultState = .error(error: error)
            }
        }
    }
    
    func handleInteractionType(_ type: CollectionInteraction) {
        return
    }
    
    func giveMeHeaderComponent() -> (collection: CollectionModel, author: AuthorModel) {
        return (
            collection: model,
            author: AuthorModel(
                name: "1",
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
