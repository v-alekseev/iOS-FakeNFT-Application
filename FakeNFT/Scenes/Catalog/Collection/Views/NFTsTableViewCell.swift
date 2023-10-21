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
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Служебный заголовок потом удалю"
        lbl.textAlignment = .left
        lbl.font = .bodyBold
        lbl.textColor = .ypBlackWithDarkMode
        return lbl
    }()
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
        collection.register(NFTCell.self)
        
        setupUI()
        contentView.layoutIfNeeded()
        print(collection.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(with source: NFTDataSourceProtocol) {
        self.dataSource = source
        self.collection.reloadData()
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        contentView.addSubview(collection)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

extension NFTsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dataSource?.numberOfNFTs() ?? 0)
        return dataSource?.numberOfNFTs() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NFTCell = collection.dequeueReusableCell(indexPath: indexPath)
        cell.cellWidth = floor((collection.frame.width - (numberOfColumns - 1)) / numberOfColumns)
        print("pre comfigurecell")
        guard let dataSource = dataSource,
              let NFT = dataSource.nft(at: indexPath) 
        else { return cell }
        
        cell.configureCell(isLiked: dataSource.isNFTLiked(at: indexPath), isOrdered: dataSource.isNFTOrdered(at: indexPath), NFT:NFT)
        print("post comfigurecell")
        return cell
    }
}

extension NFTsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - (numberOfColumns - 1)) / numberOfColumns
        return CGSize(width: width, height: width) // или другая высота, если это необходимо
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
