//
//  PayCollectionViewCell.swift
//  FakeNFT
//
//  Created by Vitaly on 18.10.2023.
//

import UIKit
import Kingfisher

final class PayCollectionViewCell: UICollectionViewCell,  ReuseIdentifying  {
    
    private (set) var currency: Currency?
    
    private lazy var imageCanvasView: UIView = {
        let view = UIView()
        view.backgroundColor = .ypBlackWithDarkMode
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currencyImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var currencyNameLabel = UILabel(font:  UIFont.caption2)
    private lazy var currencyCodeLabel = UILabel(font: UIFont.caption2, textColor: .ypGreen)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .ypLightGreyWithDarkMode //.red // .clear
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.ypBlackWithDarkMode.cgColor
    
        setupUI()
    }
    
    func setup(currency: Currency) {
        let imageURL = URL(string: currency.image)
        currencyImage.kf.setImage(with: imageURL, placeholder:  UIImage(resource: .cur))
        currencyNameLabel.text = currency.title
        currencyCodeLabel.text = currency.name
        
        self.currency = currency
    }
    
    func selectCell(isSelected: Bool) {
        contentView.layer.borderWidth = isSelected ? 1 : 0
    }    
    
    private func setupUI() {
        self.contentView.addSubview(imageCanvasView)
        NSLayoutConstraint.activate([
            imageCanvasView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageCanvasView.widthAnchor.constraint(equalToConstant: 36),
            imageCanvasView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageCanvasView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        
        self.imageCanvasView.addSubview(currencyImage)
        NSLayoutConstraint.activate([
            currencyImage.centerXAnchor.constraint(equalTo: imageCanvasView.centerXAnchor),
            currencyImage.widthAnchor.constraint(equalToConstant: 31.5),
            currencyImage.centerYAnchor.constraint(equalTo: imageCanvasView.centerYAnchor),
            currencyImage.heightAnchor.constraint(equalToConstant: 31.5)
        ])
        
        self.contentView.addSubview(currencyNameLabel)
        NSLayoutConstraint.activate([
            currencyNameLabel.leadingAnchor.constraint(equalTo: imageCanvasView.trailingAnchor, constant: 4),
            currencyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
        
        self.contentView.addSubview(currencyCodeLabel)
        NSLayoutConstraint.activate([
            currencyCodeLabel.leadingAnchor.constraint(equalTo: imageCanvasView.trailingAnchor, constant: 4),
            currencyCodeLabel.topAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
