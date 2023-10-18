//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 16.10.2023.
//

import Foundation
final class CollectionViewModel: CollectionViewModelProtocol {
    private var dataSource: DataProviderInteractorProtocol
    
    var navigationClosure: (CollectionNavigationState) -> Void = {_ in }
    private (set) var navigationState: CollectionNavigationState = .base {
        didSet {
            navigationClosure(navigationState)
        }
    }
    
    init(dataSource: DataProviderInteractorProtocol) {
        self.dataSource = dataSource
    }
}
