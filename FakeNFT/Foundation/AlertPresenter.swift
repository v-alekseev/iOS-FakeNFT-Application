//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit
final class AlertPresenter {
    
    func show(in vc: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.title, message: model.message, preferredStyle: .alert)
        let primaryAction = UIAlertAction(title: model.primaryButtonText, style: .default) { _ in
            model.primaryButtonCompletion()
        }
        alert.addAction(primaryAction)
        
        // Проверяем наличие второй кнопки
        if let secondaryButtonText = model.secondaryButtonText,
           let secondaryButtonCompletion = model.secondaryButtonCompletion {
            
            let secondaryAction = UIAlertAction(title: secondaryButtonText, style: .default) { _ in
                secondaryButtonCompletion()
            }
            alert.addAction(secondaryAction)
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
}
