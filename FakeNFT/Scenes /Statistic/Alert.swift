//
//  Alert.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 14.10.2023.
//

import UIKit

final class Alert {
    
    static let shared = Alert()
    
    func showAlert(_ alertController: UIViewController?, message: String? = "", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(
            title: L10n.Alert.error,
            message: message,
            preferredStyle: .alert)
        alert.addAction(.init(title: L10n.Alert.cancel, style: .cancel))
        alert.addAction(.init(title: L10n.Alert.repeat, style: .default, handler: handler))
        alertController?.present(alert, animated: true)
    }
}
