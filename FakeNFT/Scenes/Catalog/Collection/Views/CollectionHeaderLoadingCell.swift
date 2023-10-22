//
//  CollectionHeaderLoadingView.swift
//  FakeNFT
//
//  Created by Александр Поляков on 22.10.2023.
//

import UIKit

final class CollectionHeaderLoadingCell: UITableViewCell, ReuseIdentifying {
    
    private lazy var titleGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    private lazy var titleImageGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12, onlyLowerCorners: true)
    
    private lazy var descriptionGradient = AnimatedGradientView(frame: self.bounds, cornerRadius: 12)
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        hyerarchyUI()
        constraintUI()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        startAnimation()
    }
    
    private func hyerarchyUI() {
        contentView.addSubview(titleImageGradient)
        contentView.addSubview(titleGradient)
        contentView.addSubview(descriptionGradient)
        
        titleImageGradient.translatesAutoresizingMaskIntoConstraints = false
        titleGradient.translatesAutoresizingMaskIntoConstraints = false
        descriptionGradient.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constraintUI() {
        NSLayoutConstraint.activate([
            titleImageGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleImageGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            titleImageGradient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleImageGradient.heightAnchor.constraint(equalToConstant: 310),
            
            titleGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleGradient.topAnchor.constraint(equalTo: titleImageGradient.bottomAnchor, constant: 16),
            titleGradient.heightAnchor.constraint(equalToConstant: 30),
            titleGradient.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionGradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionGradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionGradient.topAnchor.constraint(equalTo: titleGradient.bottomAnchor, constant: 8),
            descriptionGradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            descriptionGradient.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func startAnimation() {
        titleImageGradient.startAnimating()
        titleGradient.startAnimating()
        descriptionGradient.startAnimating()
    }
}
