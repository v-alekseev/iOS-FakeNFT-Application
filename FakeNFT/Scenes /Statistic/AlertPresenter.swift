//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 14.10.2023.
//

import UIKit

final class AlertPresenter {
    
    static let shared = AlertPresenter()
    
    func showAlert(_ alertController: UIViewController?, alert: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: alert,
            preferredStyle: .alert)
        alert.addAction(.init(title: "Закрыть", style: .cancel))
        alertController?.present(alert, animated: true)
    }
}

