//
//  StatisticCell.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit
import Kingfisher

final class StatisticCell: UITableViewCell, ReuseIdentifying {
    
    private let urlSession = URLSession.shared
    
    private lazy var roundRect: UIView = {
        let roundRect = UIView()
        roundRect.layer.masksToBounds = true
        roundRect.layer.cornerRadius = 16
        roundRect.backgroundColor = .ypLightGreyWithDarkMode
        return roundRect
    }()
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.image = userAvatarStub
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var nftCountLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var userAvatarStub = UIImage(resource: .userAvatarStub)
    
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
            avatarView.kf.indicatorType = .activity
            avatarView.kf.setImage(with: url, placeholder: userAvatarStub,
                                   options: [.transition(.fade(1))])
        }
        nameLabel.text = "\(userData.name)"
        nftCountLabel.text = "\(userData.nfts.count)"
        userRatingLabel.text = Int(userData.rating) != nil ? userData.rating : ""
    }
    
    private func setupView() {
        
        backgroundColor = .clear
        [roundRect, avatarView, nameLabel, nftCountLabel, userRatingLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            roundRect.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset4),
            roundRect.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset4),
            roundRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset51),
            roundRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset16),
            
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: roundRect.leadingAnchor, constant: Constants.offset16),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.offset28),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.offset28),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.offset8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: roundRect.trailingAnchor, constant: -Constants.offset70),
            
            nftCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftCountLabel.trailingAnchor.constraint(equalTo: roundRect.trailingAnchor, constant: -Constants.offset16),
            nftCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor),
            
            userRatingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset16),
            userRatingLabel.trailingAnchor.constraint(lessThanOrEqualTo: roundRect.leadingAnchor)
        ])
    }
}

extension StatisticCell {
    private enum Constants {
        static let offset4: CGFloat = 4
        static let offset8: CGFloat = 8
        static let offset16: CGFloat = 16
        static let offset28: CGFloat = 28
        static let offset51: CGFloat = 51
        static let offset70: CGFloat = 70
    }
}

