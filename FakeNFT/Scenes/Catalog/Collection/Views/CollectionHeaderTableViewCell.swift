//
//  CollectionHeaderTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 18.10.2023.
//

import UIKit
import Kingfisher

final class CollectionHeaderTableViewCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - Elements
    private let titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        let path = UIBezierPath(roundedRect: imageView.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer

        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.headline3
        label.textColor = .ypBlackWithDarkMode
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.caption2
        textView.textColor = .ypBlackWithDarkMode
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private let placeholderImage = UIImage(named: "CatPlaceholder")
    
    private lazy var animatedGradient: AnimatedGradientView = {
        return AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    }()
    
    static let cellHeight: CGFloat = 374

    
    
}
