//
//  CartDeleteViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 11.10.2023.
//

import UIKit
import ProgressHUD


final class CartDeleteViewController: UIViewController {
    
    // MARK: - Properties
    //
    var viewModel: CartDeleteViewModelProtocol?
    
    private lazy var canvasView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nftImageView: UIImageView = {
        var image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var qestionLabel = UILabel(font: UIFont.caption2, text: L10n.Cart.DeleteConfirmScreen.confiremText)
    private lazy var returnButton = UIButton(title: L10n.Cart.DeleteConfirmScreen.returnButtonTitle, cornerRadius: 12, font: .bodyRegular)
    private lazy var deleteButton = UIButton(title: L10n.Cart.DeleteConfirmScreen.deleteButtonTitle, cornerRadius: 12, titleColor: .ypRed, font: .bodyRegular)

    // MARK:  - UIViewController(*)
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnButton.addTarget(self, action: #selector(returnButtonTap), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        
        qestionLabel.textAlignment = .center
        
        nftImageView.image = viewModel?.nftImage
        
        setupUIElementsConstraints()
    }
    
    // MARK:  - Actions
    //
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
    
    // MARK:  - Private Methods
    //
    private func showLoader(_ isShow: Bool) {
        isShow ? ProgressHUD.show() : ProgressHUD.dismiss()
        returnButton.isEnabled = !isShow
        deleteButton.isEnabled = !isShow
    }
    
    private func setupUIElementsConstraints() {
        // добавление blur на background
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight  )
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
                
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


