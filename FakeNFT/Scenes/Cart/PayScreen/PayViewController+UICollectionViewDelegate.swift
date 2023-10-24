//
//  PayViewController+UICollectionViewDelegate.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import UIKit

extension PayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = currencyCollectionView.cellForItem(at: indexPath) as? PayCollectionViewCell
        cell?.selectCell(isSelected: true)
        viewModel?.selectedCurrency = cell?.currency
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = currencyCollectionView.cellForItem(at: indexPath) as? PayCollectionViewCell
        cell?.selectCell(isSelected: false)
    }
}

