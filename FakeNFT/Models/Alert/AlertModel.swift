//
//  AlertModel.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import Foundation
struct AlertModel {
    var title: String
    var message: String
    var primaryButtonText: String
    var primaryButtonCompletion: (() -> ())
    var secondaryButtonText: String?
    var secondaryButtonCompletion: (() -> ())?
}
