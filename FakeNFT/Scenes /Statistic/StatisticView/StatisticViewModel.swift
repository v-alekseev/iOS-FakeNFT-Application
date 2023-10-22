//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import Foundation
import Combine

final class StatisticViewModel {
    
    @Published var usersData: [UserModel] = []
    @Published var isLoading = false
    @Published var actualUserData: UserModel?
    @Published var loadError = false
    @Published var needShowFilterMenu = false
    
    private let dataProvider: StatisticDataProviderProtocol?
    private let filtrationType = FiltrationTypeStorage()
    
    var rowForOpenUserCard: Int = 0 {
        didSet {
            actualUserData = usersData[rowForOpenUserCard]
        }
    }
    
    init(dataProvider: StatisticDataProviderProtocol) {
        self.dataProvider = dataProvider
        loadUsersData()
    }
    
    func loadUsersData() {
        isLoading = true
        loadError = false
        dataProvider?.getUsersData() { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.usersData = data
                    if self.filtrationType.filterByName {
                        self.provideNameFilter()
                    } else {
                        self.provideRatingFilter()
                    }
                case .failure(_):
                    self.loadError = true
                }
                self.isLoading = false
            }
        }
    }
    
    func didTapFilterButton() {
        needShowFilterMenu = true
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
