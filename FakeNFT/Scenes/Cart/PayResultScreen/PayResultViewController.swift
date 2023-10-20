//
//  PayResultViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import UIKit

final class PayResultViewController: UIViewController {
    
    private lazy var sucsessImageView: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var infoLabel: UILabel = {
        var label = UILabel()
        label.font =  UIFont.headline3
        label.text = "Успех! Оплата прошла,\nпоздравляем с покупкой!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var toCatalogButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вернуться в каталог", for: .normal)
        button.titleLabel?.font =  UIFont.bodyBold
        button.setTitleColor(.ypWhiteWithDarkMode, for: .normal)
        button.backgroundColor = .ypBlackWithDarkMode
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toCatalpgButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteWithDarkMode
        
        sucsessImageView.image = UIImage(resource: .paySuccsesful)
        setupUI()
    }
    
    @objc
    private func toCatalpgButtonTap() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(sucsessImageView)
        NSLayoutConstraint.activate([
            sucsessImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
            sucsessImageView.widthAnchor.constraint(equalToConstant: 278),
            sucsessImageView.heightAnchor.constraint(equalToConstant: 278),
            sucsessImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: sucsessImageView.bottomAnchor,constant: 20),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(toCatalogButton)
        NSLayoutConstraint.activate([
            toCatalogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toCatalogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toCatalogButton.heightAnchor.constraint(equalToConstant: 60),
            toCatalogButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        
    }
}


