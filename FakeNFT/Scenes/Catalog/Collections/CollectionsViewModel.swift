//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
final class CollectionsViewModel: CollectionsViewModelProtocol {
    
    private var dataSource: NFTCollectionsDataSource?
    
    var navigationClosure: (CollectionsNavigationState) -> Void = {_ in }
    private (set) var navigationState: CollectionsNavigationState = .base {
        didSet {
            navigationClosure(navigationState)
        }
    }
    
    var resultClosure: (CollectionsResultState) -> Void = {_ in }
    private (set) var resultState: CollectionsResultState = .start {
        didSet {
            resultClosure(resultState)
        }
        
    }
    
    func howManyCollections() -> Int {
        if let ds = dataSource {
            return ds.howManyCollections()
        }
        return 0
    }
    
    func getCollection(at indexPath: IndexPath) -> CollectionModel? {
        return dataSource?.giveMeCollectionAt(index: indexPath.row, withSort: true)
    }
    
    func refresh(isPullRefresh: Bool = false) {
        resultState = isPullRefresh ? .start : .loading
        if let ds = dataSource {
            
            ds.reloadCollections() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.resultState = .show
                case .failure(let error):
                    self.resultState = .error(error)
                }
            }
        } else {
            self.dataSource = NFTCollectionsDataSource(dataProvider: CatalogDataProvider()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.resultState = .show
                    print( self.resultState)
                case .failure(let error):
                    self.resultState = .error(error)
                }
            }
        }
    }
    
    func handleNavigation(action: CollectionNavigationAction) {
        switch action {
            
        case .collectionDidTapped(let collection):
            navigationState = .collectionDetails(collection: collection)
            
        case .pullToRefresh:
            refresh(isPullRefresh: true)
            navigationState = .base
            
        case .sortingDidTapped:
            navigationState = .sortSelection
            
        case .sortDidSelected(let which):
            resultState = .loading
            
            switch which {
            case .byNFTQuantity:
                dataSource?.sortCollectionsByNFTQuantity()
            case .byName:
                dataSource?.sortCollectionsByName()
            }
            
            navigationState = .base
            resultState = .show
            
        case .sortIsCancelled:
            navigationState = .base
        }
    }
    
    func bind(to controller: CollectionsViewController) {
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
