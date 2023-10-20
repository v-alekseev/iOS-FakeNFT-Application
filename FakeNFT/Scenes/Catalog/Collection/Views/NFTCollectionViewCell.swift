//
//  NFTCollectionViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit

final class NFTCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    // MARK: - Elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.headline3
        label.textColor = .ypBlackWithDarkMode
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.currency
        label.textColor = .ypBlackWithDarkMode
        label.numberOfLines = 1
        return label
    }()
    
    var cellWidth: CGFloat = 0
    
    private let placeholderImage = UIImage(named: "CatPlaceholder")
    
    private lazy var animatedGradient: AnimatedGradientView = {
        return AnimatedGradientView(
            frame: self.bounds, cornerRadius: 12,
            onlyLowerCorners: true
        )
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
