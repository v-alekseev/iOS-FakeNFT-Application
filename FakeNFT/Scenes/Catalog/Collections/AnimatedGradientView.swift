//
//  AnimatedGradientView.swift
//  FakeNFT
//
//  Created by Александр Поляков on 15.10.2023.
//

import UIKit
class AnimatedGradientView: UIView {
    
    private var cornerRadiusValue: CGFloat = 0.0
    
    private let gradientLayer = CAGradientLayer()
    
    init(frame: CGRect, cornerRadius: CGFloat) {
        self.cornerRadiusValue = cornerRadius
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0.098, green: 0.098, blue: 0.439, alpha: 1).cgColor,  // Темно-синий
            UIColor(red: 0.510, green: 0.078, blue: 0.686, alpha: 1).cgColor,  // Фиолетовый
            UIColor(red: 0.961, green: 0.269, blue: 0.435, alpha: 1).cgColor,   // Ярко-розовый
            UIColor(red: 0.510, green: 0.078, blue: 0.686, alpha: 1).cgColor,  // Фиолетовый
            UIColor(red: 0.098, green: 0.098, blue: 0.439, alpha: 1).cgColor  // Темно-синий
        ]
        gradientLayer.locations = [-0.75, -0.5, -0.25, 0.25, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadiusValue
        gradientLayer.masksToBounds = true
        layer.addSublayer(gradientLayer)
    }

    func startAnimating() {
        let animation = CAKeyframeAnimation(keyPath: "locations")
        animation.values = [
            [-1.5, -1.25, -1, -0.5, -0.25],
            [-1, -0.75, -0.5, 0, 0.25],
            [-0.5, -0.25, 0, 0.5, 0.75],
            [0, 0.25, 0.5, 1, 1.25],
            [0.5, 0.75, 1, 1.5, 1.75],
            [1, 1.25, 1.5, 2, 2.25],  // добавлено
            [1.5, 1.75, 2, 2.5, 2.75] // добавлено
        ]
        animation.keyTimes = [0, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 1]  // изменено
        animation.duration = 3
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "locationsChange")
    }




    
    func stopAnimating() {
        gradientLayer.removeAnimation(forKey: "locationsChange")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
