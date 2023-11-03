//
//  PayViewController+UICollectionViewDelegateFlowLayout.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import UIKit

struct CollectionLayout {
    static let trailingOffsetCell: Double = 16
    static let leadingOffsetCell: Double = 16
    static let topOffsetCell: Double = 20
    static let heightOfCell: Double = 46
    static let spaceBetweenColumns: Double = 7
    static let spaceBetweenRows: Double = 7
    static let countOfColumsCell: Double = 2
}

extension PayViewController: UICollectionViewDelegateFlowLayout {
    // размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let speceBetweenCells = CollectionLayout.leadingOffsetCell+CollectionLayout.trailingOffsetCell+CollectionLayout.spaceBetweenColumns
        let cellWight = (collectionView.bounds.width - speceBetweenCells)/CollectionLayout.countOfColumsCell
        return CGSize(width: cellWight, height: CollectionLayout.heightOfCell)
    }
    // отступ между яейками в одном ряду  (горизонтальные отступы)   // отвечает за горизонтальные отступы между ячейками.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionLayout.spaceBetweenColumns
    }
    
    // отступы ячеек от краев  коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CollectionLayout.topOffsetCell, left: CollectionLayout.leadingOffsetCell, bottom: 10, right: CollectionLayout.trailingOffsetCell)
    }
    // отвечает за вертикальные отступы  между яцейками в коллекции;
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionLayout.spaceBetweenRows
    }
}
