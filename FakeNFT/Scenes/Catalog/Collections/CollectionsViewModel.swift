//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
final class CollectionsViewModel: CollectionsViewModelProtocol {
    private var dataSource: NFTCollectionsDataSource? = nil
    private let sortTypeKey = "selectedSortType"
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
    
    init() {
        
        self.dataSource = NFTCollectionsDataSource(dataProvider: CatalogDataProvider()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.resultState = .show
            case .failure(let error):
                self.resultState = .error(error)
            }
        }
        
        if let sortType = loadSortType() {
            applySortType(sortType)
        } else {
            applySortType(.byNFTQuantity(order: .ascending))
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
        
        dataSource?.reloadCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.resultState = .show
            case .failure(let error):
                self.resultState = .error(error)
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
            resultState = .loading
            applySortType(which)
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
    
    private func saveSortType(_ type: SortType) {
        let value: String
        switch type {
        case .byName:
            value = "byName"
        case .byNFTQuantity:
            value = "byNFTQuantity"
        }
        UserDefaults.standard.setValue(value, forKey: sortTypeKey)
    }
    
    private func loadSortType() -> SortType? {
        guard let value = UserDefaults.standard.string(forKey: sortTypeKey) else {
            return nil
        }
        
        switch value {
        case "byName":
            return .byName(order: .ascending)
        case "byNFTQuantity":
            return .byNFTQuantity(order: .ascending)
        default:
            return nil
        }
    }
    
    private func applySortType(_ type: SortType) {
        switch type {
        case .byNFTQuantity:
            dataSource?.sortCollectionsByNFTQuantity()
        case .byName:
            dataSource?.sortCollectionsByName()
        }
        saveSortType(type)
    }

}
