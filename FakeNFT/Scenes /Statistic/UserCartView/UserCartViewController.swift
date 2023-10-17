//
//  UserCartViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit
import Kingfisher
import Combine

final class UserCartViewController: UIViewController {
    
    private let contentView = UserCartView()
    private let viewModel: UserCartViewModel
    private let alertPresenter = AlertPresenter.shared
    private var bindings = Set<AnyCancellable>()
    private var userID: String
    private var weburl: String
    
    init(_ viewModel: UserCartViewModel) {
        self.viewModel = viewModel
        self.userID = viewModel.actualUserData.id
        self.weburl = viewModel.actualUserData.website
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
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    func bindViewToViewModel() {
        
        contentView.$didTapCollectionButton
            .assign(to: \.didTapCollectionButton, on: viewModel)
            .store(in: &bindings)
        
        contentView.$didTapWebsiteButton
            .assign(to: \.didTapWebsiteButton, on: viewModel)
            .store(in: &bindings)
    }
    
    func bindViewModelToView() {
        
        viewModel.$actualUserData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] actualUserData in
                self?.contentView.nameLabel.text = actualUserData.name
                self?.contentView.descriptionLabel.text = actualUserData.description
                self?.contentView.nftsCountLabel.text = ("Коллекция NFT (\(actualUserData.nfts.count))")
                self?.weburl = actualUserData.website
                if  let url = URL(string: actualUserData.avatar) {
                    self?.contentView.avatarView.kf.setImage(with: url)
                }
            })
            .store(in: &bindings)
        
        viewModel.$isLoading
            .assign(to: \.isLoading, on: contentView)
            .store(in: &bindings)
        
        viewModel.$needShowCollectionScreen
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] needShowCollectionScreen in
                if needShowCollectionScreen {
                    let usersCollectionViewController = UsersCollectionViewController()
                    self?.navigationController?.pushViewController(usersCollectionViewController, animated: true)
                }
            })
            .store(in: &bindings)
        
        viewModel.$needShowWebsite
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] needShowWebsite in
                if needShowWebsite {
                    let webViewViewController = WebViewViewController(self?.weburl ?? "")
                    self?.navigationController?.pushViewController(webViewViewController, animated: true)
                }
            })
            .store(in: &bindings)
        
        viewModel.$loadError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] loadError in
                if loadError {
                    self?.alertPresenter.showAlert(self) {_ in
                        self?.viewModel.loadUserData()
                    }
                }
            })
            .store(in: &bindings)
    }
    
    @objc
    func tapBackButton() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}
