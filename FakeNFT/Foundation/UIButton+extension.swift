//
//  UIButton+extension.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import UIKit

extension UIButton {
    convenience init(title: String, cornerRadius: Double, titleColor: UIColor = .ypWhiteWithDarkMode, font: UIFont = UIFont.bodyBold ) {
        self.init()
        self.setTitle(title, for: .normal)
        self.titleLabel?.font =  font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = .ypBlackWithDarkMode
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
