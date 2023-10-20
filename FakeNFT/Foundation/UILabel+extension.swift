//
//  UILabel+extension.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, text: String = "", textColor: UIColor = .ypBlackWithDarkMode, numberOfLines: Int = 0)  {
        self.init()
        self.font =  font
        self.text = text
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
