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
    
    var userID = ""
    private lazy var avatarView = createAvatarView()
    private lazy var nameLabel = createNameLabel()
    private lazy var forwardButton = createForwardButton()
    private lazy var profileLabel = createProfileLabel()
    private lazy var websiteButton = createWebsiteButton()
    private lazy var collectionLabel = createCollectionLabel()
    private lazy var userAvatarStub = UIImage(named: "userAvatarStub")
    private var subscribes = [AnyCancellable]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let viewModel = UserCartViewModel(dataProvider: StatisticDataProvider(), userID: self.userID)
        viewModel.$actualUserData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                self?.nameLabel.text = viewModel.actualUserData.name
                self?.profileLabel.text = viewModel.actualUserData.description
                self?.collectionLabel.text = ("Коллекция NFT (\(viewModel.actualUserData.nfts.count))")
                if  let url = URL(string: viewModel.actualUserData.avatar) {
                    self?.avatarView.kf.setImage(with: url, placeholder: self?.userAvatarStub)
                }
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
        
        NSLayoutConstraint.activate([
            
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 70),
            avatarView.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            profileLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            websiteButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 28),
            websiteButton.heightAnchor.constraint(equalToConstant: 40),
            websiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            websiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionLabel.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: 56),
            collectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: forwardButton.leadingAnchor, constant: 16),
            
            forwardButton.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
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
        //TODO 
        print (#function)
    }
}
