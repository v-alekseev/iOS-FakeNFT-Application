//
//  PayViewController+UICollectionViewDataSource.swift
//  FakeNFT
//
//  Created by Vitaly on 20.10.2023.
//

import UIKit

extension PayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.currencies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PayCollectionViewCell = currencyCollectionView.dequeueReusableCell(indexPath: indexPath)
        guard let currency = viewModel?.currencies[indexPath.row] else { return cell }
        cell.setup(currency: currency)
        return cell
    }
}
