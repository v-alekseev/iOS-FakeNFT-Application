//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Vitaly on 09.10.2023.
//

import Foundation
import UIKit
import Kingfisher

protocol CartTableViewCellDelegate: AnyObject {
    func didDeleteButtonPressed(id: String, image: UIImage)
}

final class CartTableViewCell: UITableViewCell, ReuseIdentifying {
    // MARK: - Consts
    
    private lazy var placeholderImage = UIImage(resource: .nftNo)
    weak var delegate: CartTableViewCellDelegate?
    
    private var nftID: String = ""
    
    private lazy var canvasView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nftImage: UIImageView = {
        var image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel = UILabel(font: .bodyBold)
    private lazy var ratingView = RatingView()
    
    private lazy var priceNameLabel = UILabel(font: .caption2, text: L10n.Cart.priceLabelName)
    private lazy var priceLabel = UILabel(font: .bodyBold)
    
    private lazy var trashButton: UIButton = {
        var button = UIButton()
        button.tintColor = .ypBlackWithDarkMode
        button.setImage(UIImage(resource: .cartRemove).withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .ypWhiteWithDarkMode
        setupUI()
        setup(imageUrl: URL(string: ""), name: "-", rank: 0, price: "0 ETH", id: "0")
    }
    
    func setup(imageUrl: URL?, name: String, rank: Int, price: String, id: String ) {
        // заполняем данными ячейку
        nftImage.kf.setImage(with: imageUrl, placeholder: placeholderImage)
        nameLabel.text = name
        priceLabel.text = price
        nftID = id

    
        ratingView.setRating(rank: rank)

    }
    
    func setup(nfs: NftModel) {
        setup(imageUrl: nfs.imageUrl, name: nfs.name, rank: nfs.rating, price: String(nfs.price), id: nfs.id )
    }
    
    /// Функция обрабатывает нажатие на кнопку удалить
    @objc
    private func deleteButtonTap() {        
        let image = nftImage.image ?? placeholderImage
        delegate?.didDeleteButtonPressed(id: nftID, image: image)
    }

    private func setupUI() {
        self.contentView.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            canvasView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            canvasView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            canvasView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        self.contentView.addSubview(nftImage)
        NSLayoutConstraint.activate([
            nftImage.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            nftImage.widthAnchor.constraint(equalToConstant: 108),
            nftImage.topAnchor.constraint(equalTo: canvasView.topAnchor),
            nftImage.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
        
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 8),
        ])
        
        self.contentView.addSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: 12),
            ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ])
        
        self.contentView.addSubview(priceNameLabel)
        NSLayoutConstraint.activate([
            priceNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceNameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 12),
        ])
        
        self.contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: priceNameLabel.bottomAnchor, constant: 2),
        ])
        
        self.contentView.addSubview(trashButton)
        NSLayoutConstraint.activate([
            trashButton.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            trashButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
