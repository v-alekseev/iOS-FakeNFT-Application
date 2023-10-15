//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import Foundation
import Combine

final class StatisticViewModel {
    
    @Published var usersData: [UserModel]
    @Published var dataLoad: Bool
    @Published var possibleError: Error?
    
    private let dataProvider: StatisticDataProviderProtocol?
    private let filtrationType = FiltrationTypeStorage()
    
    init(dataProvider: StatisticDataProviderProtocol) {
        self.usersData = []
        self.dataProvider = dataProvider
        self.dataLoad = true
        loadUserData()
    }
    
    func loadUserData() {
        dataProvider?.getUsersData() { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.usersData = data
                    self.possibleError = nil
                    if self.filtrationType.filterByName {
                        self.provideNameFilter()
                    } else {
                        self.provideRatingFilter()
                    }
                case let .failure(error):
                    self.possibleError = error
                }
                self.dataLoad = false
            }
        }
    }
    
    func provideNameFilter() {
        usersData = usersData.sorted(by: {
            $0.name < $1.name
        })
        filtrationType.filterByName = true
    }
    
    func provideRatingFilter() {
        usersData = usersData.sorted(by: {
            Int($0.rating) ?? 0 < Int($1.rating) ?? 0
        })
        filtrationType.filterByName = false
    }
}
