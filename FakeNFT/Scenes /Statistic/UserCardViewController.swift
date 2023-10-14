//
//  UserCardViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit
import Kingfisher
import Combine

final class UserCardViewController: UIViewController {
    
    private let viewModel: UserCartViewModel
    private var subscribes = [AnyCancellable]()
    private var userID: String
    private var weburl: String
    private lazy var avatarView = createAvatarView()
    private lazy var nameLabel = createNameLabel()
    private lazy var forwardButton = createForwardButton()
    private lazy var profileLabel = createProfileLabel()
    private lazy var websiteButton = createWebsiteButton()
    private lazy var collectionLabel = createCollectionLabel()
    private lazy var loadIndicator = createActivityIndicator()
    private lazy var userAvatarStub = UIImage(named: "userAvatarStub")
    
    init(_ viewModel: UserCartViewModel) {
        self.viewModel = viewModel
        self.userID = viewModel.actualUserData.id
        self.weburl = viewModel.actualUserData.website
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.$actualUserData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                if self?.viewModel.dataLoad == true {
                    self?.loadIndicator.startAnimating()
                } else {
                    self?.loadIndicator.stopAnimating()
                }
                self?.nameLabel.text = self?.viewModel.actualUserData.name
                self?.profileLabel.text = self?.viewModel.actualUserData.description
                self?.collectionLabel.text = ("Коллекция NFT (\( self?.viewModel.actualUserData.nfts.count ?? 0))")
                if  let url = URL(string: self?.viewModel.actualUserData.avatar ?? "") {
                    self?.avatarView.kf.setImage(with: url, placeholder: self?.userAvatarStub)
                }
                self?.weburl = self?.viewModel.actualUserData.website ?? ""
            })
            .store(in: &subscribes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tapBackButton))
        leftBarButton.tintColor = .ypBlackWithDarkMode
        navigationItem.leftBarButtonItem  = leftBarButton
        
        view.backgroundColor = .ypWhiteWithDarkMode
        view.addSubview(forwardButton)
        view.addSubview(avatarView)
        view.addSubview(nameLabel)
        view.addSubview(profileLabel)
        view.addSubview(websiteButton)
        view.addSubview(collectionLabel)
        view.addSubview(loadIndicator)
        
        NSLayoutConstraint.activate([
            
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.offset_20),
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset_16),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.offset_70),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.offset_70),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.offset_16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset_16),
            
            profileLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.offset_20),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset_16),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset_16),
            
            websiteButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: Constants.offset_28),
            websiteButton.heightAnchor.constraint(equalToConstant: Constants.offset_40),
            websiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset_16),
            websiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset_16),
            
            collectionLabel.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: Constants.offset_56),
            collectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset_16),
            collectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: forwardButton.leadingAnchor, constant: Constants.offset_16),
            
            forwardButton.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset_20),
            
            loadIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    
    private func createForwardButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.init(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .ypBlackWithDarkMode
        button.addTarget(self, action: #selector(tapForwardButton), for: .touchUpInside)
        return button
    }
    
    private func createAvatarView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 35
        imageView.image = userAvatarStub
        return imageView
    }
    
    private func createNameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = .ypBlackWithDarkMode
        return label
    }
    
    private func createProfileLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = .ypBlackWithDarkMode
        label.numberOfLines = 0
        return label
    }
    
    private func createWebsiteButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .caption1
        button.backgroundColor = .ypWhiteWithDarkMode
        button.setTitleColor(.ypBlackWithDarkMode, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = button.currentTitleColor.cgColor
        button.setTitle("Перейти на сайт пользователя", for: .normal)
        button.addTarget(self, action: #selector(tapWebsiteButton), for: .touchUpInside)
        return button
    }
    
    private func createCollectionLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = .ypBlackWithDarkMode
        return label
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }
    
    @objc
    private func tapBackButton() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func tapForwardButton() {
        let usersCollectionViewController = UsersCollectionViewController()
        navigationController?.pushViewController(usersCollectionViewController, animated: true)
    }
    
    @objc
    private func tapWebsiteButton() {
        let webViewViewController = WebViewViewController(weburl)
        navigationController?.pushViewController(webViewViewController, animated: true)
    }
}

extension UserCardViewController {
    private enum Constants {
        static let offset_16: CGFloat = 16
        static let offset_20: CGFloat = 20
        static let offset_28: CGFloat = 28
        static let offset_40: CGFloat = 40
        static let offset_56: CGFloat = 56
        static let offset_70: CGFloat = 70
    }
}
