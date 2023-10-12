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
    
    private let dataProvider: StatisticDataProviderProtocol?
    
    init(dataProvider: StatisticDataProviderProtocol) {
        self.usersData = []
        self.dataProvider = dataProvider
        
        dataProvider.getUsersData() { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.usersData = data
                    if UserDefaults.standard.bool(forKey: "statisticFilterByName") {
                        self.provideNameFilter()
                    } else {
                        self.provideRatingFilter()
                    }
                case let .failure(error):
                    print (error)
                }
            }
        }
    }
    
    func provideNameFilter() {
        usersData = usersData.sorted(by: {
            $0.name < $1.name
        })
        UserDefaults.standard.set(true, forKey: "statisticFilterByName")
    }
    
    func provideRatingFilter() {
        usersData = usersData.sorted(by: {
            Int($0.rating) ?? 0 < Int($1.rating) ?? 0
        })
        UserDefaults.standard.set(false, forKey: "statisticFilterByName")
    }
}
