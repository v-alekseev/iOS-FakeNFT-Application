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
        
        viewModel.$isLoading
            .assign(to: \.isLoading, on: contentView)
            .store(in: &bindings)
        
        viewModel.$showStub
            .assign(to: \.showStub, on: contentView)
            .store(in: &bindings)
        
        viewModel.$loadError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] loadError in
                if loadError {
                    self?.alertPresenter.showAlert(self) {_ in
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

