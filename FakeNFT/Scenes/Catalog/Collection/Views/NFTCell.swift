//
//  NFTCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit
import Kingfisher

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
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    private let basketButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    private lazy var animatedGradient: AnimatedGradientView = {
        let gr = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
        gr.translatesAutoresizingMaskIntoConstraints = false
        return gr
    }()
    
    private let placeholderImage = UIImage(resource: .nftPlaceholder)
    
    private var basketCompletion: (() -> Void) = {}
    private var likeCompletion: (() -> Void) = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
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
        contentView.addSubview(likeButton)
        contentView.addSubview(basketButton)
        contentView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            NFTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            NFTImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            NFTImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            NFTImage.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            NFTImage.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            animatedGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animatedGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animatedGradient.topAnchor.constraint(equalTo: contentView.topAnchor),
            animatedGradient.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            animatedGradient.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingView.topAnchor.constraint(equalTo: NFTImage.bottomAnchor, constant: Constants.offset_8),
            ratingView.heightAnchor.constraint(equalToConstant: Constants.offset_8),
            
            likeButton.trailingAnchor.constraint(equalTo: NFTImage.trailingAnchor, constant: Constants.minus_offset_10),
            likeButton.topAnchor.constraint(equalTo: NFTImage.topAnchor, constant: Constants.offset_11),
            
            NFTNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            NFTNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: basketButton.leadingAnchor),
            NFTNameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: Constants.offset_5),
            
            NFTCostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            NFTCostLabel.trailingAnchor.constraint(lessThanOrEqualTo: basketButton.leadingAnchor),
            NFTCostLabel.topAnchor.constraint(equalTo: NFTNameLabel.bottomAnchor, constant: Constants.offset_4),
            
            basketButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            basketButton.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: Constants.offset_4),
        ])
        animatedGradient.isHidden = true
    }
    
    @objc private func likeButtonTapped() {
        likeCompletion()
    }
    
    @objc private func basketButtonTapped() {
        basketCompletion()
    }
    
    func configureCell(isLiked: Bool, isOrdered: Bool, NFT: NFTModel) {
        animatedGradient.isHidden = false
        animatedGradient.startAnimating()
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        let options: KingfisherOptionsInfo = [
            .backgroundDecode,
            .onFailureImage(placeholderImage.kf.image(withBlendMode: .normal, backgroundColor: .ypBlackWithDarkMode)),
            .processor(processor)
        ]
        
        NFTImage.kf.setImage(
            with: URL(string: NFT.images[0]),
            placeholder: placeholderImage,
            options: options,
            completionHandler: { [weak self] _ in
                guard let self = self else { return }
                self.animatedGradient.stopAnimating()
                self.animatedGradient.isHidden = true
            })
        
        NFTNameLabel.text = NFT.name
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let formattedPrice = numberFormatter.string(from: NSNumber(value: NFT.price)) {
            NFTCostLabel.text = "\(formattedPrice) ETH"
        } else {
            NFTCostLabel.text = "\(NFT.price) ETH"
        }
        
        ratingView.setRating(rank: Int(NFT.rating))
        basketButton.setImage(isOrdered ? UIImage(resource: .inBasket) : UIImage(resource: .notInBasket), for: .normal)
        likeButton.setImage(isLiked ? UIImage(resource: .likeActive) : UIImage(resource: .likeInactive), for: .normal)
    }
    
    func setBasketCompletion(completion: @escaping () -> Void) {
        basketCompletion = completion
    }
    
    func setLikeCompletion(completion: @escaping () -> Void) {
        likeCompletion = completion
    }
}
