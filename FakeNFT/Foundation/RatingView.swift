//
//  RatingComponet.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

// КАК ИСПОЛЬЗОВАТЬ
// Размер по умолчанию 5 звезд
// Обязательны картинки в ресурсах .star : .starGray
// Использовать так.

// ratingView = RatingView()
//
// ratingView.setRating(rank: 3)  -  установить 3 золотые звезды
//
//+ констрейнты для ratingView


import UIKit

final class RatingView: UIStackView {
    let maxRating: Int
    
    init(maxRating: Int = 5) {
        self.maxRating = maxRating
        
        super.init(frame: .zero)
        
        self.axis  = NSLayoutConstraint.Axis.horizontal
        self.distribution  = UIStackView.Distribution.equalSpacing
        self.alignment = UIStackView.Alignment.leading
        self.spacing = 2
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRating(rank: Int) {
        var computedRank = rank
        if rank < 1 ||  rank > maxRating  {
            computedRank = 0
        }
        
        clear()
        for index in 1...maxRating {
            self.addArrangedSubview(createStarView(index <= computedRank ? .star : .starGray))
        }
    }
    
    private func clear() {
        for view in self.subviews {
            self.removeArrangedSubview(view)
        }
    }

    private func createStarView(_ star: ImageResource) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(resource: star)
        return image
    }
}
