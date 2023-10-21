//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 14.10.2023.
//

import UIKit

final class AlertPresenter {
    
    static let shared = AlertPresenter()
    
    func showAlert(_ alertController: UIViewController?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Не удалось получить данные",
            message: nil,
            preferredStyle: .alert)
        alert.addAction(.init(title: "Отмена", style: .cancel))
        alert.addAction(.init(title: "Повторить", style: .default, handler: handler))
        alertController?.present(alert, animated: true)
    }
}
