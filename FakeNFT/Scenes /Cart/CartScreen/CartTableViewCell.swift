//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Vitaly on 09.10.2023.
//

import Foundation
import UIKit
import Kingfisher


final class CartTableViewCell: UITableViewCell, ReuseIdentifying {
    //NFTcard
    // MARK: - Consts
    //static let cellID = "cartCell"
    //static var defaultReuseIdentifier = "cartCall"
    
    private let placeholderImage = UIImage(resource: .nftNo)
    
    private var canvasView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nftImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyBold
        return label
    }()
    
    private let stackView: UIStackView  = {
        var sView = UIStackView()
        sView.axis  = NSLayoutConstraint.Axis.horizontal
        sView.distribution  = UIStackView.Distribution.equalSpacing
        sView.alignment = UIStackView.Alignment.leading
        sView.spacing = 2
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    private var starImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var priceNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.caption2
        label.text = L10n.Cart.priceLabelName
        return label
    }()
    
    private var priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyBold
        return label
    }()
    
    private lazy var trashButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(resource: .cartRemove), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setup(imageUrl: URL(string: ""), name: "-", rank: 0, price: "0 ETH")
    }
    
    func setup(imageUrl: URL?, name: String, rank: Int, price: String ) {
        // заполняем данными ячейку
        nftImage.kf.setImage(with: imageUrl, placeholder: placeholderImage)
        nameLabel.text = name //"April"
        priceLabel.text = price //"1,78 ETH"
        
        var computedRank = rank
        if rank < 1 ||  rank > 5  {
            computedRank = 0
        }
        
        // сначала показываються заглушки. поэтому надо обязательно очистить stackView от старых subview
        for view in stackView.subviews {
            stackView.removeArrangedSubview(view)
        }
        // а теперь уже запольнить новыми звездами
        for index in 1...5 {
            stackView.addArrangedSubview(createStarView(index <= computedRank ? .star : .starGray))
        }
    }
    
    func setup(nfs: NftModel) {
        setup(imageUrl: nfs.imageUrl, name: nfs.name, rank: nfs.rating, price: String(nfs.price) )
    }
    
    /// Функция обрабатывает нажатие на кнопку фильтр
    @objc
    private func deleteButtonTap() {
        print("deleteButtonTap")
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
        
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            //stackView.widthAnchor.constraint(equalToConstant: 108),
            stackView.heightAnchor.constraint(equalToConstant: 12),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ])
        
        
        self.contentView.addSubview(priceNameLabel)
        NSLayoutConstraint.activate([
            priceNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceNameLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
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
    
    private func createStarView(_ star: ImageResource) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(resource: star)
        return image
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
