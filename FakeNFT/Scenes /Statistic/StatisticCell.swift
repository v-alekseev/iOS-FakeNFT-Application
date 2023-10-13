//
//  StatisticCell.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit
import Kingfisher

final class StatisticCell: UITableViewCell, ReuseIdentifying {
    
    static let defaultReuseIdentifier = "StatisticCell"
    private let urlSession = URLSession.shared
    
    private lazy var roundRect = createRoundRect()
    private lazy var avatarView = createAvatarView()
    private lazy var nameLabel = createNameLabel()
    private lazy var nftCountLabel = createNftCountLabel()
    private lazy var userRatingLabel = createUserRatingLabel()
    private lazy var userAvatarStub = UIImage(named: "userAvatarStub")
    
    private var task: URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func provide(userData: UserModel) {
        if let url = URL(string: userData.avatar) {
            avatarView.kf.setImage(with: url, placeholder: userAvatarStub)
        }
        nameLabel.text = "\(userData.name)"
        nftCountLabel.text = "\(userData.nfts.count)"
        userRatingLabel.text = Int(userData.rating) != nil ? userData.rating : ""
    }
    
    private func setupView() {
        
        backgroundColor = .clear
        addSubview(roundRect)
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(nftCountLabel)
        addSubview(userRatingLabel)
        
        NSLayoutConstraint.activate([
            
            roundRect.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset_4),
            roundRect.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset_4),
            roundRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset_51),
            roundRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset_16),
            
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: roundRect.leadingAnchor, constant: Constants.offset_16),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.offset_28),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.offset_28),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.offset_8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: roundRect.trailingAnchor, constant: -Constants.offset_70),
            
            nftCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftCountLabel.trailingAnchor.constraint(equalTo: roundRect.trailingAnchor, constant: -Constants.offset_16),
            nftCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor),
            
            userRatingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset_16),
            userRatingLabel.trailingAnchor.constraint(lessThanOrEqualTo: roundRect.leadingAnchor)
            
        ])
    }
    
    private func createRoundRect() -> UIView {
        let roundRect = UIView()
        roundRect.translatesAutoresizingMaskIntoConstraints = false
        roundRect.layer.masksToBounds = true
        roundRect.layer.cornerRadius = 16
        roundRect.backgroundColor = .ypLightGreyWithDarkMode
        return roundRect
    }
    
    private func createAvatarView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }
    
    private func createNameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = .ypBlackWithDarkMode
        return label
    }
    
    private func createNftCountLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = .ypBlackWithDarkMode
        return label
    }
    
    private func createUserRatingLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption1
        label.textColor = .ypBlackWithDarkMode
        return label
    }
}

extension StatisticCell {
    private enum Constants {
        static let offset_4: CGFloat = 4
        static let offset_8: CGFloat = 8
        static let offset_16: CGFloat = 16
        static let offset_28: CGFloat = 28
        static let offset_51: CGFloat = 51
        static let offset_70: CGFloat = 70
    }
}

