//
//  UsersCollectionView.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 18.10.2023.
//

import UIKit
import Combine

final class UsersCollectionView: UIView {
    
    @Published var dataForUpdateCartState: (nftId: String, isInCart: Bool, indexPath: IndexPath)? = nil
    
    var nfts: [NftModel] = []
    var nftsIdForDisplayingLikes: [String] = []
    var nftsInCartId: [String] = []
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .ypBlackWithDarkMode
        label.text = "У пользователя ещё нет NFT"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(UsersCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func reloadCell(indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    private func setUpViews() {
        backgroundColor = .ypWhiteWithDarkMode
        [collectionView, loadIndicator, stubLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            loadIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            stubLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stubLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

extension UsersCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nfts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UsersCollectionCell.defaultReuseIdentifier,
            for: indexPath) as? UsersCollectionCell
        let nftData = nfts[indexPath.row]
        let isLiked = nftsIdForDisplayingLikes.contains(nftData.id)
        cell?.provide(nftData: nftData, isLiked: isLiked)
        let isInCart = nftsInCartId.contains(nftData.id)
        cell?.isInCart = isInCart
        cell?.setCartCompletion {
            self.dataForUpdateCartState = (nftData.id, isInCart, indexPath)
        }
        return cell ?? UsersCollectionCell()
    }
}

extension UsersCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 2 * Constants.fromEdge - 2 * Constants.betweenСells) / 3, height: Constants.heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Constants.fromEdge, bottom: 0, right: Constants.fromEdge)
    }
}

extension UsersCollectionView {
    private enum Constants {
        static let betweenСells: CGFloat = 10
        static let fromEdge: CGFloat = 16
        static let heightCell: CGFloat = 192
    }
}
