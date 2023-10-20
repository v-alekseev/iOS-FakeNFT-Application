//
//  UsersCollectionCell.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 15.10.2023.
//

import UIKit
import Kingfisher

final class UsersCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var imageNftView = createImageNftView()
    private lazy var footerView = createFooterView()
    private lazy var nftNameLabel = createNftNameLabel()
    private lazy var cartButton = createCartButton()
    private lazy var priceLabel = createPriceLabel()
    private lazy var likeImageView = createLikeImageView()
    
    private lazy var imageNftStub = UIImage(named: "nftStub")
    
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
    
    func provide(nftData: NftModel, isLiked: Bool, isInCart: Bool) {
        if  let firstImage = nftData.images.first,
            let url = URL(string: firstImage) {
            imageNftView.kf.indicatorType = .activity
            imageNftView.kf.setImage(with: url,
                                     placeholder: imageNftStub,
                                     options: [.transition(.fade(1)),
                                               .forceRefresh])
        }
        
        nftNameLabel.text = nftData.name
        priceLabel.text = String(format: "%.2f", nftData.price) + " ETH"
        let isLikedImage = isLiked ? UIImage(named: "isLiked") : UIImage(named: "isNotLiked")
        likeImageView.image = isLikedImage
        let buttonImage = isInCart ? UIImage(named: "deleteFromCart") : UIImage(named: "addFromCart")
        cartButton.setImage(buttonImage, for: .normal)
    }
    
    private func setupView() {
        
        [imageNftView, footerView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [nftNameLabel, priceLabel, cartButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        imageNftView.addSubview(likeImageView)
        
        footerView.backgroundColor = .green
        
        NSLayoutConstraint.activate([
            
            imageNftView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageNftView.heightAnchor.constraint(equalToConstant: 108),
            imageNftView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageNftView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: imageNftView.bottomAnchor, constant: Constants.offset_8),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nftNameLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            nftNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nftNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: cartButton.leadingAnchor),
            
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40),
            cartButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: cartButton.leadingAnchor),
            
            likeImageView.topAnchor.constraint(equalTo: imageNftView.topAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: imageNftView.trailingAnchor),
            likeImageView.heightAnchor.constraint(equalToConstant: 40),
            likeImageView.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    private func createImageNftView() -> UIImageView {
        let imageNftView = UIImageView()
        imageNftView.contentMode = .scaleAspectFill
        imageNftView.layer.masksToBounds = true
        imageNftView.layer.cornerRadius = 12
        imageNftView.image = imageNftStub
        return imageNftView
    }
    
    private func createLikeImageView() -> UIImageView {
        let likeImageView = UIImageView()
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.contentMode = .scaleAspectFill
        return likeImageView
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView()
        return footerView
    }
    
    private func createNftNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .ypBlackWithDarkMode
        return label
    }
    
    private func createCartButton() -> UIButton {
        let cartButton = UIButton.systemButton(with: UIImage(),
                                               target: self,
                                               action: #selector(tapCartButton))
        cartButton.tintColor = .ypBlackWithDarkMode
        return cartButton
    }
    
    private func createPriceLabel() -> UILabel {
        let label = UILabel()
        label.font = .medium10
        label.textColor = .ypBlackWithDarkMode
        return label
    }
    
    @objc
    private func tapCartButton() {
        //TODO
        print(#function)
    }
    
}

extension UsersCollectionCell {
    private enum Constants {
        static let offset_8: CGFloat = 8
    }
}
