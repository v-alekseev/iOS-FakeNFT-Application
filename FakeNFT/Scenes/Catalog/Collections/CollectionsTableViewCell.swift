//
//  CollectionsTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit
final class CollectionsTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let imageCollection = UIImageView()
    static let cellHeight: CGFloat = 179
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .ypWhiteWithDarkMode
        
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
            imageCollection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageCollection.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageCollection.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
        ])
    }
}
