//
//  FiltrationTypeStorage.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 13.10.2023.
//

import Foundation

final class FiltrationTypeStorage {
    
    private let key = "statisticFilterByName"
    private let userDefaultsStandart = UserDefaults.standard
    
    var filterByName: Bool {
        get {
            return userDefaultsStandart.bool(forKey: key)
        }
        set {
            userDefaultsStandart.set(newValue, forKey: "statisticFilterByName")
        }
    }
}
