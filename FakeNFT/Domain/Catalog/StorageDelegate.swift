//
//  StorageDelegate.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

protocol StorageDelegate {
    func notifyAboutLoadingState(isLoading: Bool)
}
