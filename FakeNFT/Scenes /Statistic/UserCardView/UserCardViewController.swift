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
    
    private let contentView = UserCardView()
    private let viewModel: UserCardViewModel
    private var alertPresenter = Alert.shared
    private var bindings = Set<AnyCancellable>()
    private var actualUserData: UserModel
    private lazy var userAvatarStub = UIImage(resource: .userAvatarStub)
    
    init(_ viewModel: UserCardViewModel) {
        self.viewModel = viewModel
        self.actualUserData = viewModel.actualUserData
        
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
        
        contentView.nameLabel.text = actualUserData.name
        contentView.descriptionLabel.text = actualUserData.description
        contentView.nftsCountLabel.text = ("Коллекция NFT (\(actualUserData.nfts.count))")
        contentView.avatarView.kf.indicatorType = .activity
        contentView.avatarView.kf.setImage(with: URL(string: actualUserData.avatar),
                                                 placeholder: userAvatarStub,
                                                 options: [.transition(.fade(1)),
                                                           .forceRefresh])
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    func bindViewToViewModel() {
        
        viewModel.$isLoading
            .assign(to: \.isLoading, on: contentView)
            .store(in: &bindings)
        
        viewModel.$loadError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] loadError in
                if loadError {
                    self?.alertPresenter.showAlert(self) {_ in
                        self?.viewModel.loadProfileLikes()
                    }
                }
            })
            .store(in: &bindings)
        
        contentView.$didTapCollectionButton
            .assign(to: \.didTapCollectionButton, on: viewModel)
            .store(in: &bindings)
        
        contentView.$didTapWebsiteButton
            .assign(to: \.didTapWebsiteButton, on: viewModel)
            .store(in: &bindings)
    }
    
    func bindViewModelToView() {
        
        viewModel.$needShowCollectionScreen
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] needShowCollectionScreen in
                if needShowCollectionScreen,
                   let actualUserData = self?.actualUserData,
                   let profileLikes = self?.viewModel.profileLikes {
                    let dataProvider = StatisticDataProvider()
                    let viewModel = UsersCollectionViewModel(dataProvider: dataProvider,
                                                             actualUserData: actualUserData,
                                                             profileLikes: profileLikes)
                    let viewController = UsersCollectionViewController(viewModel)
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            })
            .store(in: &bindings)
        
        viewModel.$needShowWebsite
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] needShowWebsite in
                if needShowWebsite {
                    let webViewViewController = WebViewViewController(self?.actualUserData.website ?? "")
                    self?.navigationController?.pushViewController(webViewViewController, animated: true)
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
