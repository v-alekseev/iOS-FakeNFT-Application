//
//  CollectionsTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit
import Kingfisher
final class CollectionsTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let imageCollection = UIImageView()
    private let placeholderImage = UIImage(named: "CatPlaceholder")
    private lazy var animatedGradient: AnimatedGradientView = {
        return AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    }()
    static let cellHeight: CGFloat = 179
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .ypBlackWithDarkMode
        
        imageCollection.layer.cornerRadius = 12
        imageCollection.layer.masksToBounds = true
        imageCollection.contentMode = .scaleAspectFill
        contentView.addSubview(imageCollection)
        contentView.addSubview(titleLabel)
        animatedGradient.isHidden = true
        contentView.addSubview(animatedGradient)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        animatedGradient.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            imageCollection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageCollection.heightAnchor.constraint(equalToConstant: 140),
            
            animatedGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            animatedGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            animatedGradient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            animatedGradient.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 4),
        ])
    }
    
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
            options: options, completionHandler: { [weak self] _ in
                guard let self = self else { return }
                self.animatedGradient.stopAnimating()
                self.animatedGradient.isHidden = true
            })
        let quantity: Int  = collection.nfts.count
        titleLabel.text = "\(collection.name) (\(quantity))"
    }
    
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
        contentView.backgroundColor = .white
        }
    
}
