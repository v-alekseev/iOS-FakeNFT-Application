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
        textView.isSelectable = true
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    private let placeholderImage = UIImage(resource: .catPlaceholder)
    
    private lazy var animatedGradient: AnimatedGradientView = {
        return AnimatedGradientView(
            frame: self.bounds, cornerRadius: 12,
            onlyLowerCorners: true
        )
    }()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubviews()
        setupConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        animatedGradient.isHidden = true
    }
    
    private func addSubviews() {
        contentView.addSubview(titleImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(animatedGradient)
        
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        animatedGradient.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            titleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleImage.heightAnchor.constraint(equalToConstant: 310),
            
            animatedGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            animatedGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            animatedGradient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            animatedGradient.heightAnchor.constraint(equalToConstant: 310),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 16),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func maskImage(with size: CGSize) {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        titleImage.layer.mask = maskLayer
        
    }
    
    // MARK: - Configure Methods
    func configureCell(
        with collection: CollectionModel,
        author: AuthorModel,
        linkDelegate: UITextViewDelegate,
        imageSize: CGSize
    ) {
        animatedGradient.isHidden = false
        animatedGradient.startAnimating()
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        let options: KingfisherOptionsInfo = [
            .backgroundDecode,
            .onFailureImage(placeholderImage.kf.image(withBlendMode: .normal, backgroundColor: .ypBlackWithDarkMode)),
            .processor(processor)
        ]
        titleImage.kf.setImage(
            with: URL(string: collection.cover),
            placeholder: placeholderImage,
            options: options,
            completionHandler: { [weak self] _ in
                guard let self = self else { return }
                maskImage(with: imageSize)
                self.animatedGradient.stopAnimating()
                self.animatedGradient.isHidden = true
            })
        titleLabel.text = "\(collection.name)"
        let linkText = "\(L10n.Catalog.Collection.authorString): \(author.name)"
        let linkSize = author.name.count
        

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.ypBlackWithDarkMode,
            .font: UIFont.caption2
        ]
        
        let descriptionText = NSAttributedString(string: "\n\(collection.description)", attributes: attributes)
        
        let linkAttributedString = NSMutableAttributedString(string: linkText)
        let rangeOfPrefix = (linkText as NSString).range(of: "\(L10n.Catalog.Collection.authorString): ")
        linkAttributedString.addAttribute(.foregroundColor, value: UIColor.ypBlackWithDarkMode , range: rangeOfPrefix)

        linkAttributedString.addAttribute(
            .link,
            value: "\(author.website)",
            range: NSRange(
                location: linkText.count-linkSize,
                length: linkSize
            )
        )
        let finalAttributedString = NSMutableAttributedString()
        finalAttributedString.append(linkAttributedString)
        finalAttributedString.append(descriptionText)
        descriptionTextView.attributedText = finalAttributedString
        descriptionTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .font: UIFont.caption1
        ]
        descriptionTextView.delegate = linkDelegate
    }
    
    // MARK: - Support
    override func prepareForReuse() {
        super.prepareForReuse()
        titleImage.kf.cancelDownloadTask()
        titleImage.image = nil
        titleLabel.text = nil
        descriptionTextView.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
    }
}

