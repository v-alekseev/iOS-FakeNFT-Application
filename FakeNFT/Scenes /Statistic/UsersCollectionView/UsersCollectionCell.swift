//
//  UsersCollectionCell.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 15.10.2023.
//

import UIKit
import Kingfisher

final class UsersCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    var isInCart: Bool = false {
        didSet {
            let buttonImage = isInCart ? UIImage(resource: .deleteFromCart) : UIImage(resource: .addToCart)
            cartButton.setImage(buttonImage, for: .normal)
        }
    }
    
    private var cartCompletion: (() -> ()) = {}
    
    private lazy var imageNftView: UIImageView = {
        let imageNftView = UIImageView()
        imageNftView.contentMode = .scaleAspectFill
        imageNftView.layer.masksToBounds = true
        imageNftView.layer.cornerRadius = Constants.constant_12
        imageNftView.image = imageNftStub
        return imageNftView
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView()
        return footerView
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var cartButton: UIButton = {
        let cartButton = UIButton.systemButton(with: UIImage(),
                                               target: self,
                                               action: #selector(tapCartButton))
        cartButton.tintColor = .ypBlackWithDarkMode
        return cartButton
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .medium10
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var likeImageView: UIImageView = {
        let likeImageView = UIImageView()
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.contentMode = .scaleAspectFill
        return likeImageView
    }()
    
    private lazy var ratingView = RatingView()
    private lazy var imageNftStub = UIImage(resource: .nftStub)
    private var task: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func provide(nftData: NftModel, isLiked: Bool) {
        if  let firstImage = nftData.images.first,
            let url = URL(string: firstImage) {
            imageNftView.kf.indicatorType = .activity
            imageNftView.kf.setImage(with: url,
                                     placeholder: imageNftStub,
                                     options: [.transition(.fade(1)),
                                               .forceRefresh])
        }
        nftNameLabel.text = nftData.name
        ratingView.setRating(rank: nftData.rating)
        priceLabel.text = "\(nftData.price.formatPrice()) ETH"
        let isLikedImage = isLiked ? UIImage(resource: .isLiked) : UIImage(resource: .isNotLiked)
        likeImageView.image = isLikedImage
    }
    
    func setCartCompletion(completion: @escaping () -> Void) {
        cartCompletion = completion
    }
    
    private func setupView() {
        
        [imageNftView, footerView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [nftNameLabel, priceLabel, cartButton, ratingView].forEach {
            footerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageNftView.addSubview(likeImageView)
        
        NSLayoutConstraint.activate([
            imageNftView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageNftView.heightAnchor.constraint(equalToConstant: 108),
            imageNftView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageNftView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: imageNftView.bottomAnchor, constant: Constants.offset8),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nftNameLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            nftNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nftNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: cartButton.leadingAnchor),
            
            cartButton.heightAnchor.constraint(equalToConstant: Constants.button_size),
            cartButton.widthAnchor.constraint(equalToConstant: Constants.button_size),
            cartButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: cartButton.leadingAnchor),
            
            likeImageView.topAnchor.constraint(equalTo: imageNftView.topAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: imageNftView.trailingAnchor),
            likeImageView.heightAnchor.constraint(equalToConstant: Constants.button_size),
            likeImageView.widthAnchor.constraint(equalToConstant: Constants.button_size),
            
            ratingView.topAnchor.constraint(equalTo: footerView.topAnchor),
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: Constants.constant_12),
        ])
    }
    
    @objc
    private func tapCartButton() {
        cartCompletion()
    }
}

extension UsersCollectionCell {
    private enum Constants {
        static let offset8: CGFloat = 8
        static let constant_12: CGFloat = 12
        static let button_size: CGFloat = 40
    }
}

extension Double {
    func formatPrice() -> String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

