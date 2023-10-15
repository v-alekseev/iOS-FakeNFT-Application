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
            [-1.0, -0.7, -0.5, -0.3, 0.0],
            [-0.7, -0.4, -0.2, 0.0, 0.3],
            [-0.4, -0.1, 0.1, 0.3, 0.6],
            [-0.1, 0.2, 0.4, 0.6, 0.9],
            [0.2, 0.5, 0.7, 0.9, 1.2],
            [0.5, 0.8, 1.0, 1.2, 1.5],
            [0.8, 1.1, 1.3, 1.5, 1.8],
            [0.5, 0.8, 1.0, 1.2, 1.5],
            [0.2, 0.5, 0.7, 0.9, 1.2],
            [-0.1, 0.2, 0.4, 0.6, 0.9],
            [-0.4, -0.1, 0.1, 0.3, 0.6],
            [-0.7, -0.4, -0.2, 0.0, 0.3],
            [-1.0, -0.7, -0.5, -0.3, 0.0],
        ]
        animation.keyTimes = [0, 0.08, 0.15, 0.23, 0.31, 0.38, 0.46, 0.54, 0.62, 0.69, 0.77, 0.85, 0.92, 1]
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
