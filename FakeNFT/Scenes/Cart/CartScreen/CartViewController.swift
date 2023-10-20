//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 08.10.2023.
//

import UIKit
import ProgressHUD

final class CartViewController: UIViewController {
    // MARK: - Properties
    //
    private (set) var viewModel: CartViewModelProtocol?
    
    private lazy var bottomView: UIView = {
        var view = UIView()
        view.backgroundColor = .ypLightGreyWithDarkMode
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var countItemsLabel = UILabel(font: UIFont.caption1)
    private lazy var totalAmountLabel = UILabel(font: UIFont.bodyBold, textColor:  .ypGreen)
    private lazy var paymentButton = UIButton(title: L10n.Cart.paymentButtonTitle, cornerRadius: 16)
    
    private (set) lazy var cartTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .ypWhiteWithDarkMode
        return table
    }()

    private lazy var emptyCartLabel = UILabel(font: .bodyBold, text:  L10n.Cart.CartScreen.emptyCartMessage )
    
    // MARK: - UIViewController(*)
    //
    
    init(viewModel: CartViewModelProtocol? = CartViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (viewModel?.order.count == 0 ) {
            showLoader(true)
            viewModel?.getOrder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteWithDarkMode
        
        viewModel?.delegate = self
        
        setupNavigationBar()
        
        paymentButton.addTarget(self, action: #selector(paymentButtonTap), for: .touchUpInside)
  
        cartTable.register(CartTableViewCell.self)
        cartTable.delegate = self
        cartTable.dataSource = self
        
        configureRefreshControl()
        updateTotal()
        
        setupUIElementsConstraints()
    }
    
    // MARK: - Actions Properties
    //
    @objc private func handleRefreshControl() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.getOrder()
            self?.cartTable.refreshControl?.endRefreshing()
        }
    }
    /// Функция обрабатывает нажатие на кнопку фильтр
    @objc
    private func filterButtonTap() {
        let alert = UIAlertController(title: L10n.Filter.caption, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: L10n.Filter.byPrice, style: .default , handler:{ [weak self] (UIAlertAction) in
            guard let self = self else { return }
            self.viewModel?.filterCart(Filters.filterByPrice)
        }))
        
        alert.addAction(UIAlertAction(title: L10n.Filter.byRating, style: .default , handler:{ [weak self] (UIAlertAction) in
            guard let self = self else { return }
            self.viewModel?.filterCart(Filters.filterByRating)
        }))
        
        alert.addAction(UIAlertAction(title: L10n.Filter.byName, style: .default , handler:{ [weak self] (UIAlertAction) in
            guard let self = self else { return }
            self.viewModel?.filterCart(Filters.filterByName)
        }))
        
        alert.addAction(UIAlertAction(title: L10n.Filter.close, style: .cancel, handler:{(UIAlertAction) in
        }))
        
        self.present(alert, animated: true)
    }
    
    /// Функция обрабатывает нажатие на кнопку оплаты
    @objc
    private func paymentButtonTap() {
        let vc = PayViewController()
        vc.viewModel = PayViewModel()
        vc.hidesBottomBarWhenPushed = true
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Internal Properties
    //
    internal func showLoader(_ isShow: Bool) {
        isShow ? ProgressHUD.show(): ProgressHUD.dismiss()
        paymentButton.isEnabled = !isShow
    }
    internal func hideCart(_ isHidden: Bool) {
        emptyCartLabel.isHidden = !isHidden
        
        cartTable.isHidden = isHidden
        bottomView.isHidden = isHidden
    }
    internal func updateTotal() {
        countItemsLabel.text = "\(viewModel?.order.count ?? 00) NFT"
        totalAmountLabel.text = "\(String(format: "%.2f", viewModel?.totalPrice ?? 0)) ETH"
    }
    
    // MARK: - Private Methods
    //
    private func configureRefreshControl () {
        cartTable.refreshControl = UIRefreshControl()
        cartTable.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    ///настройка NAvigationBar
    private func setupNavigationBar() {
        guard let navBar = navigationController?.navigationBar else  { return }
        let rightButton = UIBarButtonItem(image: UIImage(resource: .sort), style: .plain, target: self, action: #selector(filterButtonTap))
        rightButton.tintColor = .ypBlackWithDarkMode
        navBar.topItem?.setRightBarButton(rightButton, animated: false)
    }
    
    private func setupUIElementsConstraints() {
        view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 76),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(cartTable)
        NSLayoutConstraint.activate([
            cartTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTable.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
        ])
        
        bottomView.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            paymentButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            paymentButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16),
            paymentButton.widthAnchor.constraint(equalToConstant: 240),
        ])
        
        bottomView.addSubview(countItemsLabel)
        NSLayoutConstraint.activate([
            countItemsLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            countItemsLabel.trailingAnchor.constraint(equalTo: paymentButton.leadingAnchor, constant: -5),
            countItemsLabel.heightAnchor.constraint(equalToConstant: 20),
            countItemsLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16)
        ])
        
        bottomView.addSubview(totalAmountLabel)
        NSLayoutConstraint.activate([
            totalAmountLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            totalAmountLabel.trailingAnchor.constraint(equalTo: paymentButton.leadingAnchor, constant: -5),
            totalAmountLabel.heightAnchor.constraint(equalToConstant: 22),
            totalAmountLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16)
        ])
        
        view.addSubview(emptyCartLabel)
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

