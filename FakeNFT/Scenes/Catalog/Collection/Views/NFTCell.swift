//
//  NFTCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit

final class NFTCell: UICollectionViewCell, ReuseIdentifying {
    
    private let NFTNameLabel: UILabel = {
            let lbl = UILabel()
            lbl.textAlignment = .left
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.font = .bodyBold
            lbl.numberOfLines = 1
            lbl.lineBreakMode = .byTruncatingTail
            lbl.textColor = .ypBlackWithDarkMode
            return lbl
        }()
    
    private let NFTCostLabel: UILabel = {
            let lbl = UILabel()
            lbl.textAlignment = .left
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.numberOfLines = 1
            lbl.lineBreakMode = .byTruncatingTail
            lbl.font = .currency
            lbl.textColor = .ypBlackWithDarkMode
            return lbl
        }()
    
    var imageWidth: CGFloat = 0
    
    private let NFTImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 12
        img.clipsToBounds = true
        return img
    }()
    
    private let ratingView = RatingView()
    
    private let likeImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let basketImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var animatedGradient: AnimatedGradientView = {
        let gr = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
        gr.translatesAutoresizingMaskIntoConstraints = false
        return gr
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(NFTNameLabel)
        contentView.addSubview(NFTCostLabel)
        contentView.addSubview(NFTImage)
        contentView.addSubview(animatedGradient)
        contentView.addSubview(ratingView)
        contentView.addSubview(likeImage)
        contentView.addSubview(basketImage)
        
        contentView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            NFTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            NFTImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            NFTImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            NFTImage.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            NFTImage.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            animatedGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            animatedGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            animatedGradient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            animatedGradient.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            animatedGradient.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            ratingView.topAnchor.constraint(equalTo: NFTImage.bottomAnchor, constant: 8),
            ratingView.heightAnchor.constraint(equalToConstant: 12),
            
            likeImage.trailingAnchor.constraint(equalTo: NFTImage.trailingAnchor, constant: -10),
            likeImage.topAnchor.constraint(equalTo: NFTImage.topAnchor, constant: 11),
            
            NFTNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            NFTNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: basketImage.leadingAnchor, constant: 0),
            NFTNameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 5),
            
            NFTCostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            NFTCostLabel.trailingAnchor.constraint(lessThanOrEqualTo: basketImage.leadingAnchor, constant: 0),
            NFTCostLabel.topAnchor.constraint(equalTo: NFTNameLabel.bottomAnchor, constant: 4),
            
            basketImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            basketImage.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 4),
        ])
        animatedGradient.isHidden = true
    }
    
    func configureCell(isLiked: Bool, isOrdered: Bool, NFT: NFTModel) {
        NFTNameLabel.text = NFT.name
        NFTCostLabel.text = "\(NFT.price) ETH"
        ratingView.setRating(rank: Int(NFT.rating))
        basketImage.image = isOrdered ? UIImage(named: "InBasket") : UIImage(named: "NotInBasket")
        likeImage.image = isLiked ? UIImage(named: "LikeActive") : UIImage(named: "LikeInactive")
        if (isLiked) {
            likeImage.tintColor = .ypLightGreyWithDarkMode
        }
        NFTImage.image = UIImage(named: "NFTPlaceholder")
    }
    
}
