//
//  RatingView.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit

class RatingView: UIView {
    private var stackView: UIStackView!
    private var stars: [UIImageView] = []
    
    var activeStarColor: UIColor = .ypYellow
    var inactiveStarColor: UIColor = .ypLightGreyWithDarkMode
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2.0
        
        for _ in 1...5 {
            let starImageView = UIImageView(image: UIImage(named: "Star"))
            starImageView.contentMode = .scaleAspectFit
            stars.append(starImageView)
            stackView.addArrangedSubview(starImageView)
        }
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setRating(_ rating: Int) {
        for i in 0..<stars.count {
            if i < rating {
                stars[i].tintColor = activeStarColor
            } else {
                stars[i].tintColor = inactiveStarColor
            }
        }
    }
}
