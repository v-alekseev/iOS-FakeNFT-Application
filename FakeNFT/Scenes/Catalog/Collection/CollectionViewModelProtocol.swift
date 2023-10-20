//
//  CollectionViewModelProtocol.swift
//  FakeNFT
//
//  Created by Александр Поляков on 16.10.2023.
//

import Foundation

protocol CollectionViewModelProtocol {
    func giveMeHeaderComponent() -> (collection: CollectionModel, author: AuthorModel?)
    func handleInteractionType(_ type: CollectionInteraction)
    func bind(to controller: CollectionViewController)
    func refresh(withCommonData: Bool)
    func clearLinks()
}

extension CollectionViewModelProtocol {
    func refresh() {
        refresh(withCommonData: false)
    }
}
