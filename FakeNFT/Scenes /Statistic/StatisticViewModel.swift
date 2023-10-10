//
//  StatisticViewModel.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import Foundation
import Combine


final class StatisticViewModel {

    @Published var userData: [UserModel]

    private let userDataProvider: UserDataProvider

    init(userDataProvider: UserDataProvider) {
        self.userData = []
        self.userDataProvider = userDataProvider
        userDataProvider.getActualUserData { userData in
            self.userData = userData
            if UserDefaults.standard.bool(forKey: "statisticFilterByName") {
                self.provideNameFilter()
            } else {
                self.provideRatingFilter()
            }
        }
    }

    func provideNameFilter() {
        userData = userData.sorted(by: {
            $0.name < $1.name
        })
        UserDefaults.standard.set(true, forKey: "statisticFilterByName")
    }

    func provideRatingFilter() {
        userData = userData.sorted(by: {
            Int($0.rating) ?? 0 < Int($1.rating) ?? 0
        })
        UserDefaults.standard.set(false, forKey: "statisticFilterByName")
    }
}
