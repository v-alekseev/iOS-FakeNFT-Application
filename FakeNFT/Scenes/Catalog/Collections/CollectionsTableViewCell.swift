//
//  CollectionsTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit
import Kingfisher
final class CollectionsTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let imageCollection = UIImageView()
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
        
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            imageCollection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageCollection.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 4),
        ])
    }
    
    func configureCell(with collection: CollectionModel) {
        imageCollection.kf.setImage(with: URL(string: collection.cover))
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
