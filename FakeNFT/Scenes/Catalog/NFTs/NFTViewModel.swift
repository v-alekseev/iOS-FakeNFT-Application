//
//  NFTViewModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 16.10.2023.
//

import Foundation
final class NFTViewModel: NFTViewModelProtocol {
    private var dataSource: DataProviderInteractorProtocol
    
    var navigationClosure: (NFTNavigationState) -> Void = {_ in }
    private (set) var navigationState: NFTNavigationState = .base {
        didSet {
            navigationClosure(navigationState)
        }
    }
    
    init(dataSource: DataProviderInteractorProtocol) {
        self.dataSource = dataSource
    }
}
