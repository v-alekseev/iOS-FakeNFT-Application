//
//  StatisticCell.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit

final class StatisticCell: UITableViewCell, ReuseIdentifying {

    static var defaultReuseIdentifier = "StatisticCell"
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
        if  let url = URL(string: userData.avatar) {
            let task = urlSession.dataTask(with: .init(url: url) ) { [weak self] (data, _, _) in
                guard let self,
                      let data,
                      !(self.task?.progress.isCancelled ?? false)
                else { return }
                let avatarImage = UIImage(data: data)
                self.task = nil

                DispatchQueue.main.async {
                    self.avatarView.image = avatarImage
                }
            }
            task.resume()
            self.task = task
            avatarView.image = userAvatarStub
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

            roundRect.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            roundRect.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            roundRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 51),
            roundRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: roundRect.leadingAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 28),
            avatarView.widthAnchor.constraint(equalToConstant: 28),

            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: roundRect.trailingAnchor, constant: -70),

            nftCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftCountLabel.trailingAnchor.constraint(equalTo: roundRect.trailingAnchor, constant: -16),
            nftCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor),

            userRatingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
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
