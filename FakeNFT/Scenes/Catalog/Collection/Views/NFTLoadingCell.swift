//
//  NFTLoadingCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 22.10.2023.
//

import UIKit

final class NFTLoadingCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var nameGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    private lazy var costGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    var imageWidth: CGFloat = 0
    
    private lazy var imageGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    private lazy var ratingGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    private lazy var basketGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(nameGradient)
        contentView.addSubview(costGradient)
        contentView.addSubview(imageGradient)
        contentView.addSubview(ratingGradient)
        contentView.addSubview(basketGradient)
        contentView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            imageGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageGradient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageGradient.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageGradient.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            ratingGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            ratingGradient.topAnchor.constraint(equalTo: imageGradient.bottomAnchor, constant: 8),
            ratingGradient.heightAnchor.constraint(equalToConstant: 12),
            ratingGradient.widthAnchor.constraint(equalToConstant: 60),
            
            
            nameGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameGradient.trailingAnchor.constraint(lessThanOrEqualTo: basketGradient.leadingAnchor, constant: 0),
            nameGradient.topAnchor.constraint(equalTo: ratingGradient.bottomAnchor, constant: 5),
            nameGradient.heightAnchor.constraint(equalToConstant: 22),
            nameGradient.widthAnchor.constraint(equalToConstant: 55),
            
            costGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            costGradient.trailingAnchor.constraint(lessThanOrEqualTo: basketGradient.leadingAnchor, constant: 0),
            costGradient.topAnchor.constraint(equalTo: nameGradient.bottomAnchor, constant: 4),
            costGradient.heightAnchor.constraint(equalToConstant: 12),
            costGradient.widthAnchor.constraint(equalToConstant: 25),
            
            basketGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            basketGradient.topAnchor.constraint(equalTo: ratingGradient.bottomAnchor, constant: 12),
            basketGradient.heightAnchor.constraint(equalToConstant: 20),
            basketGradient.widthAnchor.constraint(equalToConstant: 20),
        ])
        startAnimation()
    }
    
    private func startAnimation() {
        nameGradient.startAnimating()
        costGradient.startAnimating()
        imageGradient.startAnimating()
        ratingGradient.startAnimating()
        basketGradient.startAnimating()
    }
}
