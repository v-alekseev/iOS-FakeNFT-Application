//
//  NFTsTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit

final class NFTsTableViewCell: UITableViewCell, ReuseIdentifying {
    // MARK: - Elements
    private var collection: UICollectionView
    private var dataSource: NFTDataSourceProtocol?
    let numberOfColumns: CGFloat = 3
    var selectedIndexPath: IndexPath? = nil

    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collection.isScrollEnabled = false
        collection.dataSource = self
        collection.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(with source: NFTDataSourceProtocol) {
        self.dataSource = source
    }
}

extension NFTsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfNFTs() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NFTCollectionViewCell = collection.dequeueReusableCell(indexPath: indexPath)
        cell.cellWidth = floor((collection.frame.width - (numberOfColumns - 1)) / numberOfColumns)
        cell.backgroundColor = .red
        return cell
    }
}
