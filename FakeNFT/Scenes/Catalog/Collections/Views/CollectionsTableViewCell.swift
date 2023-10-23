//
//  CollectionsTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit
import Kingfisher

final class CollectionsTableViewCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.textColor = .ypBlackWithDarkMode
        label.numberOfLines = 1
        return label
    }()
    
    private let imageCollection: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let placeholderImage = UIImage(named: "CatPlaceholder")
    
    private lazy var animatedGradient: AnimatedGradientView = {
        return AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    }()
    
    static let cellHeight: CGFloat = 179
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupCell() {
        hyerarchyUI()
        constraintUI()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        animatedGradient.isHidden = true
    }
    
    private func hyerarchyUI() {
        contentView.addSubview(imageCollection)
        contentView.addSubview(titleLabel)
        contentView.addSubview(animatedGradient)
        
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        animatedGradient.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constraintUI() {
        NSLayoutConstraint.activate([
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset_16),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.minus_offset_16),

            imageCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollection.heightAnchor.constraint(equalToConstant: Constants.height_140),
            
            animatedGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset_16),
            animatedGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.minus_offset_16),

            animatedGradient.topAnchor.constraint(equalTo: contentView.topAnchor),
            animatedGradient.heightAnchor.constraint(equalToConstant: Constants.height_140),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset_16),
            titleLabel.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: Constants.offset_4),
        ])
    }
    
    // MARK: - Configure Methods
    func configureCell(with collection: CollectionModel) {
        animatedGradient.isHidden = false
        animatedGradient.startAnimating()
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        let options: KingfisherOptionsInfo = [
            .backgroundDecode,
            .onFailureImage(placeholderImage?.kf.image(withBlendMode: .normal, backgroundColor: .ypBlackWithDarkMode)),
            .processor(processor)
        ]
        imageCollection.kf.setImage(
            with: URL(string: collection.cover),
            placeholder: placeholderImage,
            options: options, 
            completionHandler: { [weak self] _ in
                guard let self = self else { return }
                self.animatedGradient.stopAnimating()
                self.animatedGradient.isHidden = true
            })
        let quantity: Int  = collection.nfts.count
        titleLabel.text = "\(collection.name) (\(quantity))"
    }
    
    // MARK: - Support
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCollection.kf.cancelDownloadTask()
        imageCollection.image = nil
        titleLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let margins = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .clear
    }
}
