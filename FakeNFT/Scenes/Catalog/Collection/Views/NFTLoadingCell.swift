//
//  NFTLoadingCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 22.10.2023.
//

import UIKit

final class NFTLoadingCell: UICollectionViewCell, ReuseIdentifying {
    
    var imageWidth: CGFloat = 0
    
    private lazy var imageGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        imageGradient.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageGradient)
        contentView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            imageGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageGradient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageGradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
        ])
        startAnimation()
    }
    
    private func startAnimation() {
        imageGradient.startAnimating()
    }
}
