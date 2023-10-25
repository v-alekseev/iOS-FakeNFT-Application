//
//  UsersCollectionViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit
import Combine

final class UsersCollectionViewController: UIViewController {
    
    private let contentView = UsersCollectionView()
    private let viewModel: UsersCollectionViewModel
    private var alertPresenter = Alert.shared
    private var bindings = Set<AnyCancellable>()
    
    init(_ viewModel: UsersCollectionViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contentView
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tapBackButton))
        leftBarButton.tintColor = .ypBlackWithDarkMode
        navigationItem.leftBarButtonItem  = leftBarButton
        
        navigationItem.titleView?.tintColor = .ypBlackWithDarkMode
        navigationItem.title = "Коллекция NFT"
        
        bindViewToViewModel()
        bindViewModelToView()
        
    }
    
    func bindViewToViewModel() {
        
        contentView.$dataForUpdateCartState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] data in
                if let data {
                    self?.viewModel.changeCartState(nftId: data.nftId, isInCart: data.isInCart)
                }
            })
            .store(in: &bindings)
    }
    
    func bindViewModelToView() {
        
        viewModel.$nfts
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] nfts in
                self?.contentView.nfts = nfts
                if let nftsIdForDisplayingLikes = self?.viewModel.nftsIdForDisplayingLikes {
                    self?.contentView.nftsIdForDisplayingLikes = nftsIdForDisplayingLikes
                }
                self?.contentView.reloadCollection()
            })
            .store(in: &bindings)
        
        viewModel.$nftsInCartId
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] nftsInCartId in
                if let nftsInCartId = self?.viewModel.nftsInCartId {
                    self?.contentView.nftsInCartId = nftsInCartId
                    self?.contentView.reloadCollection()
                }
            })
            .store(in: &bindings)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] isLoading in
                isLoading ? self?.contentView.loadIndicator.startAnimating() : self?.contentView.loadIndicator.stopAnimating()
            })
            .store(in: &bindings)
        
        viewModel.$showStub
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] showStub in
                self?.contentView.stubLabel.isHidden = !showStub
            })
            .store(in: &bindings)
        
        viewModel.$loadError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] loadError in
                if let loadError {
                    self?.alertPresenter.showAlert(self, message: loadError) {_ in
                        self?.viewModel.loadNftsData()
                    }
                }
            })
            .store(in: &bindings)
    }
    
    @objc
    private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

