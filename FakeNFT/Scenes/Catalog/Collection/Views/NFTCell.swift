//
//  NFTCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit

final class NFTCell: UICollectionViewCell, ReuseIdentifying {
    
    let NFTNameLabel: UILabel = {
            let lbl = UILabel()
            lbl.textAlignment = .left
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.font = .bodyBold
            lbl.textColor = .ypBlackWithDarkMode
            return lbl
        }()
    
    let NFTCostLabel: UILabel = {
            let lbl = UILabel()
            lbl.textAlignment = .left
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.font = .currency
            lbl.textColor = .ypBlackWithDarkMode
            return lbl
        }()
    
    var cellWidth: CGFloat = 0
    
    let NFTImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 12
        img.clipsToBounds = true
        return img
    }()
    
    let starImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let likeImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let basketImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
}
