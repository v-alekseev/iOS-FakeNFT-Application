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
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
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
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.tintColor = .ypBlackWithDarkMode
        button.setTitleColor(.ypBlackWithDarkMode, for: .normal)
        button.addTarget(self, action: #selector(didTapShowCollection), for: .touchUpInside)
        return button
    }()
    
    lazy var nftsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .ypBlackWithDarkMode
        label.textAlignment = .left
        return label
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
        [avatarView, nameLabel, descriptionLabel, websiteButton, forwardButton, nftsCountLabel, loadIndicator]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.offset20),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset16),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.offset70),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.offset70),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.offset16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset16),
            
            descriptionLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.offset20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset16),
            
            websiteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.offset28),
            websiteButton.heightAnchor.constraint(equalToConstant: Constants.offset40),
            websiteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset16),
            websiteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset16),
            
            forwardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset16),
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset16),
            forwardButton.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: Constants.offset40),
            forwardButton.heightAnchor.constraint(equalToConstant: Constants.offset54),
            
            nftsCountLabel.centerYAnchor.constraint(equalTo: forwardButton.centerYAnchor),
            nftsCountLabel.leadingAnchor.constraint(equalTo: forwardButton.leadingAnchor),
            nftsCountLabel.trailingAnchor.constraint(equalTo: forwardButton.trailingAnchor, constant: -Constants.offset28),
            
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
        static let offset16: CGFloat = 16
        static let offset20: CGFloat = 20
        static let offset28: CGFloat = 28
        static let offset40: CGFloat = 40
        static let offset54: CGFloat = 54
        static let offset56: CGFloat = 56
        static let offset70: CGFloat = 70
    }
}
