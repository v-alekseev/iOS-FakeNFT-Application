//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 18.10.2023.
//

import UIKit
import ProgressHUD

final class PayViewController: UIViewController {
    
    // MARK: - Consts
    //
    let termOfUseUrl = "https://yandex.ru/legal/practicum_termsofuse"
    

    // MARK: - Properties
    //
    
    var viewModel: PayViewModel?
    
    private lazy var bottomView: UIView = {
        var view = UIView()
        view.backgroundColor = .ypLightGreyWithDarkMode
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var termsOfUseLabel: UITextView = {
        let textView = UITextView()
        let url = URL(string: termOfUseUrl)?.absoluteString ?? ""
        
        let attributedString = NSMutableAttributedString(string: L10n.Cart.PayScreen.termOfUseFirstString + " " + L10n.Cart.PayScreen.termOfUseSecondString)
        

        let startPosition = L10n.Cart.PayScreen.termOfUseFirstString.count + 1
        let lenOfLink = L10n.Cart.PayScreen.termOfUseSecondString.count
        // Set the 'click here' substring to be the link
        attributedString.setAttributes([.font: UIFont.caption2], range: NSMakeRange(0, attributedString.length))
        attributedString.setAttributes([.link: url], range: NSMakeRange(startPosition, lenOfLink))

        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        // Set how links should appear: blue and underlined
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.ypBlue,
            .font: UIFont.caption2
        ]
        
        textView.delegate = self
        
        return textView
    }()
    
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

        setupUIElements()
        setupUIElementsConstraints()
        enablePayButton(false)
        
        viewModel?.getCurrensies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = L10n.Cart.PayScreen.screenHeader
    }

    // MARK: - Action Methods
    //
    
    /// Функция обрабатывает нажатие на кнопку оплаты
    @objc
    private func paymentButtonTap() {
        viewModel?.payOrder()
    }
    
    // MARK: - Internal Methods
    //
    internal func showLoader(_ isShow: Bool) {
        isShow ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
    internal func enablePayButton(_ isEnable: Bool) {
        paymentButton.isEnabled = isEnable
        paymentButton.backgroundColor = isEnable ? .ypBlackWithDarkMode : .darkGray
    }
    
    // MARK: - Private Methods
    //
    func setupUIElements() {
        guard let navBar = navigationController?.navigationBar  else { return }

        navBar.tintColor = .ypBlackWithDarkMode
        navBar.titleTextAttributes =  [ .font: UIFont.bodyBold]
        
        paymentButton.addTarget(self, action: #selector(paymentButtonTap), for: .touchUpInside)
        
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(PayCollectionViewCell.self)
    }
    
    private func setupUIElementsConstraints() {
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
            paymentButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bottomView.addSubview(termsOfUseLabel)
        NSLayoutConstraint.activate([
            termsOfUseLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            termsOfUseLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            termsOfUseLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            termsOfUseLabel.heightAnchor.constraint(equalToConstant: 44)
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

extension PayViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // Показ пользовательского соглашения
        let termsOfUseViewModel = WebViewViewModel()
        let termsOfUseVC = WebViewViewController(viewModel: termsOfUseViewModel, url: URL)
        navigationItem.title = ""
        navigationController?.pushViewController(termsOfUseVC, animated: true)
        return false // true - если открываем в системном браузере
    }
}










 

