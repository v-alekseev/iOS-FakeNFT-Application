//
//  PayCollectionViewCell.swift
//  FakeNFT
//
//  Created by Vitaly on 18.10.2023.
//

import UIKit
import Kingfisher

final class PayCollectionViewCell: UICollectionViewCell,  ReuseIdentifying  {
    
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
    
    private lazy var currencyNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.caption2
        label.textColor = .ypBlackWithDarkMode
        return label
    }()
    
    private lazy var currencyCodeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.caption2
        label.textColor = .ypGreen
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .ypLightGreyWithDarkMode //.red // .clear
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    
        setup(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png"), currencyName: "Dogecoin", currencyCode: "DOGE")
        
        setupUI()
    }
    
    func setup(imageURL: URL?, currencyName: String, currencyCode: String) {
        currencyImage.kf.setImage(with: imageURL, placeholder:  UIImage(resource: .cur))
        currencyNameLabel.text = currencyName
        currencyCodeLabel.text = currencyCode
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
            currencyImage.centerXAnchor.constraint(equalTo: imageCanvasView.centerXAnchor),  //leadingAnchor.constraint(equalTo: imageCanvasView.leadingAnchor, constant: 2.25),
            currencyImage.widthAnchor.constraint(equalToConstant: 31.5),
            currencyImage.centerYAnchor.constraint(equalTo: imageCanvasView.centerYAnchor), // topAnchor.constraint(equalTo: imageCanvasView.topAnchor, constant: 2.25),
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
