//
//  CartDeleteViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//

import Foundation
import UIKit

final class CartDeleteViewController: UIViewController {
    // in - [ID]  корзина текщая
    // in - NFTmodel для удаления
    // out - update collection
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("close", for: .normal)
        button.titleLabel?.font =  UIFont.bodyBold
        button.setTitleColor(.ypWhiteWithDarkMode, for: .normal)
        button.backgroundColor = .ypBlackWithDarkMode
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnButtonTap), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = UIScreen().bounds
        view.backgroundColor = .red
        
        setupUI()
    }
    
    /// Функция обрабатывает нажатие на кнопку оплаты
    @objc
    private func returnButtonTap() {
        print("RETURN button pressed")
        dismiss(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            returnButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
