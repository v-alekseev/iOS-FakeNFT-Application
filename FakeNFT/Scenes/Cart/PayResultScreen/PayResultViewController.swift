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
    
    private lazy var infoLabel = UILabel(font: UIFont.headline3, text: L10n.Cart.PayResultScreen.succsesPaymentText)
    
    private lazy var toCatalogButton = UIButton(title: L10n.Cart.PayResultScreen.buttonText, cornerRadius: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteWithDarkMode
        
        infoLabel.textAlignment = .center
        toCatalogButton.addTarget(self, action: #selector(toCatalpgButtonTap), for: .touchUpInside)
        
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
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36)
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


