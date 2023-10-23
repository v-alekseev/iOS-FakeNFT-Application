//
//  UserCardView.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 16.10.2023.
//

import UIKit

final class UserCardView: UIView {
    
    @Published var didTapCollectionButton = false
    @Published var didTapWebsiteButton = false
    
    var isLoading: Bool = false {
            didSet { isLoading ? loadIndicator.startAnimating() : loadIndicator.stopAnimating() }
        }
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 35
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .ypBlackWithDarkMode
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nftsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var collectionButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .ypBlackWithDarkMode
        button.addTarget(self, action: #selector(didTapShowCollection), for: .touchUpInside)
        return button
    }()
    
    private lazy var websiteButton: UIButton = {
        let button = UIButton()
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
    }()
    
    private lazy var loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)

        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        backgroundColor = .ypWhiteWithDarkMode
        [avatarView, nameLabel, collectionButton, descriptionLabel, websiteButton, nftsCountLabel, loadIndicator]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.offset_20),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset_16),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.offset_70),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.offset_70),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.offset_16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset_16),
            
            descriptionLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.offset_20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset_16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset_16),
            
            websiteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.offset_28),
            websiteButton.heightAnchor.constraint(equalToConstant: Constants.offset_40),
            websiteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset_16),
            websiteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset_16),
            
            nftsCountLabel.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: Constants.offset_56),
            nftsCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset_16),
            nftsCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: collectionButton.leadingAnchor, constant: Constants.offset_16),
            
            collectionButton.centerYAnchor.constraint(equalTo: nftsCountLabel.centerYAnchor),
            collectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset_20),
            
            loadIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc
    private func didTapShowCollection() {
        didTapCollectionButton = true
    }
    
    @objc
    private func tapWebsiteButton() {
        didTapWebsiteButton = true
    }
}

extension UserCardView {
    private enum Constants {
        static let offset_16: CGFloat = 16
        static let offset_20: CGFloat = 20
        static let offset_28: CGFloat = 28
        static let offset_40: CGFloat = 40
        static let offset_56: CGFloat = 56
        static let offset_70: CGFloat = 70
    }
}
