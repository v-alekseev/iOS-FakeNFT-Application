//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation
final class CollectionsViewModel: CollectionsViewModelProtocol {
    private var dataSource: NFTCollectionsDataSource? = nil
    
    var navigationClosure: (CollectionsNavigationState) -> Void = {_ in }
    private (set) var navigationState: CollectionsNavigationState = .base {
        didSet {
            navigationClosure(navigationState)
        }
    }
    
    var resultClosure: (CollectionsResultState) -> Void = {_ in }
    private (set) var resultState: CollectionsResultState = .start {
        didSet {
            print("vm \(resultState)")
            resultClosure(resultState)
        }
        
    }
    
    
    func setSortType(sortType: SortType) {
        print("ok")
    }
    
    func howManyCollections() -> Int {
        if let ds = dataSource {
            return ds.howManyCollections()
        }
        return 0
    }
    
    func getCollection(at indexPath: IndexPath) -> CollectionModel? {
        return dataSource?.giveMeCollectionAt(index: indexPath.row)
    }
    
    func getCollectionName(at indexPath: IndexPath) -> String {
        return ""
    }
    
    func getCollectionImage(at indexPath: IndexPath) -> String {
        return ""
    }
    
    func getCollectionNFTQuantity(at indexPath: IndexPath) -> Int {
        return 0
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
                    print("vm успешно вышла")
                    self.resultState = .show
                    print( self.resultState)
                case .failure(let error):
                    self.resultState = .error(error)
                }
            }
            print("вышел из метода")
        }
    }
    
    func handleNavigation(action: CollectionNavigationAction) {
        switch action {
        case .collectionDidTapped(let collection):
            print("VM collection didTapped")
            navigationState = .base
        case .pullToRefresh:
            refresh(isPullRefresh: true)
            navigationState = .base
        case .sorterDidTapped:
            navigationState = .sortSelection
        case .sortDidSelected(let which):
            print("VM sort did selected")
            navigationState = .base
        case .sortIsCancelled:
            print("VM sort is cancelled")
            navigationState = .base
        }
    }
}
