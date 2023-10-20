//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 18.10.2023.
//

import UIKit
import ProgressHUD

final class PayViewController: UIViewController {
    
    let termOfUseUrl = "https://yandex.ru/legal/practicum_termsofuse"
    
    var viewModel: PayViewModel?
    
    // MARK: - Private Properties
    //
    
    
    private lazy var bottomView: UIView = {
        var view = UIView()
        view.backgroundColor = .ypLightGreyWithDarkMode
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var termsOfUseFirstLineLabel = UILabel(font: UIFont.caption2, text: L10n.Cart.PayScreen.termOfUseFirstString)
    private lazy var termsOfUseSecondLineLabel = UILabel(font: UIFont.caption2, text: L10n.Cart.PayScreen.termOfUseSecondString,textColor: .ypBlue)
    
    private lazy var paymentButton = UIButton(title: L10n.Cart.paymentButtonTitle, cornerRadius: 16)
    
    lazy var currencyCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .ypWhiteWithDarkMode
        collectionView.allowsMultipleSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - UIViewController(*)
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteWithDarkMode
        viewModel?.delegate = self
        
        guard let navBar = navigationController?.navigationBar  else { return }
        navigationItem.title = L10n.Cart.PayScreen.screenHeader
        navBar.tintColor = .ypBlackWithDarkMode
        navBar.titleTextAttributes =  [ .font: UIFont.bodyBold]
        
        paymentButton.addTarget(self, action: #selector(paymentButtonTap), for: .touchUpInside)
        termsOfUseSecondLineLabel.isUserInteractionEnabled = true
        
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(PayCollectionViewCell.self)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        termsOfUseSecondLineLabel.addGestureRecognizer(tapGesture)
        
        setupUI()
        
        enablePayButton(false)
        
        viewModel?.getCurrensies()
    }
    
    internal func showLoader(_ isShow: Bool) {
        isShow ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
    internal func enablePayButton(_ isEnable: Bool) {
        paymentButton.isEnabled = isEnable
        paymentButton.backgroundColor = isEnable ? .ypBlackWithDarkMode : .darkGray
    }
    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            // Показ пользовательского соглашения
            let termsOfUseViewModel = WebViewViewModel()
            let termsOfUseVC = WebViewViewController(viewModel: termsOfUseViewModel, url: URL(string: termOfUseUrl))
            termsOfUseVC.modalPresentationStyle = .formSheet
            
            self.present(termsOfUseVC, animated: true)
        }
    }
    
    /// Функция обрабатывает нажатие на кнопку оплаты
    @objc
    private func paymentButtonTap() {
        viewModel?.payOrder()
    }
    // MARK: - Private Methods
    //
    private func setupUI() {
        view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 186),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bottomView.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -12),
            paymentButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            paymentButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -50),
            paymentButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        bottomView.addSubview(termsOfUseFirstLineLabel)
        NSLayoutConstraint.activate([
            termsOfUseFirstLineLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            termsOfUseFirstLineLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16)
        ])
        
        bottomView.addSubview(termsOfUseSecondLineLabel)
        NSLayoutConstraint.activate([
            termsOfUseSecondLineLabel.leadingAnchor.constraint(equalTo: termsOfUseFirstLineLabel.leadingAnchor),
            termsOfUseSecondLineLabel.topAnchor.constraint(equalTo: termsOfUseFirstLineLabel.bottomAnchor, constant: 4)
        ])
        
        view.addSubview(currencyCollectionView)
        NSLayoutConstraint.activate([
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currencyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyCollectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }
}










 

