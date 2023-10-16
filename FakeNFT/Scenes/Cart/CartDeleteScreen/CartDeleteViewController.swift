//
//  CartDeleteViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//

import Foundation
import UIKit
import ProgressHUD


final class CartDeleteViewController: UIViewController {
    
    var viewModel: CartDeleteViewModel?
    
    private var canvasView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nftImageView: UIImageView = {
        var image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var qestionLabel: UILabel = {
        var label = UILabel()
        label.font =  UIFont.caption2
        label.text = "Вы уверены, что хотите удалить объект из корзины?"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вернуться", for: .normal)
        button.titleLabel?.font =  UIFont.bodyBold
        button.setTitleColor(.ypWhiteWithDarkMode, for: .normal)
        button.backgroundColor = .ypBlackWithDarkMode
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font =  UIFont.bodyBold
        button.setTitleColor(.ypRed, for: .normal)
        button.backgroundColor = .ypBlackWithDarkMode
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nftImageView.image = viewModel?.nftImage
        setupUI()
    }
    
    /// Функция обрабатывает нажатие на кнопку отмены
    @objc
    private func returnButtonTap() {
        dismiss(animated: true)
    }
    
    /// Функция обрабатывает нажатие на кнопку удаления
    @objc
    private func deleteButtonTap() {
        showLoader(true)
        viewModel?.deleteNFT() { [weak self] result in
            guard let self = self else { return }
            self.showLoader(false)
            switch result {
            case .success(_):
                self.dismiss(animated: true)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func showLoader(_ isShow: Bool) {
        isShow ? ProgressHUD.show() : ProgressHUD.dismiss()
        returnButton.isEnabled = !isShow
        deleteButton.isEnabled = !isShow
    }
    
    private func setupUI() {
        
        // добавление blur на background
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight  )
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        view.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: view.topAnchor, constant: 244),
            canvasView.heightAnchor.constraint(equalToConstant: 220),
            canvasView.widthAnchor.constraint(equalToConstant: 262),
            canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        view.addSubview(nftImageView)
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: canvasView.topAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor)
        ])
        
        
        view.addSubview(qestionLabel)
        NSLayoutConstraint.activate([
            qestionLabel.topAnchor.constraint(equalTo: nftImageView.bottomAnchor,constant: 12),
            qestionLabel.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            qestionLabel.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        view.addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            returnButton.heightAnchor.constraint(equalToConstant: 44),
            returnButton.widthAnchor.constraint(equalToConstant: 127),
            returnButton.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
        
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.widthAnchor.constraint(equalToConstant: 127),
            deleteButton.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
    }
}


