//
//  UsersCollectionViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit

final class UsersCollectionViewController: UIViewController {
    
    private var nfts: [NftModel] = [NftModel(name: "AAArg",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                             rating: 1,
                                             price: 0.434304,
                                             id: "1"),
                                    NftModel(name: "Archie",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                             rating: 2,
                                             price: 9,
                                             id: "2"),
                                    NftModel(name: "Ccc",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                             rating: 3,
                                             price: 8,
                                             id: "3"),
                                    NftModel(name: "Ddd",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Biscuit/1.png"],
                                             rating: 4,
                                             price: 7,
                                             id: "4"),
                                    NftModel(name: "Eee",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Breena/1.png"],
                                             rating: 5,
                                             price: 6,
                                             id: "5"),
                                    NftModel(name: "Fff",
                                             imageURL: [""],
                                             rating: 1,
                                             price: 5,
                                             id: "6"),
                                    NftModel(name: "AAA",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                             rating: 1,
                                             price: 10,
                                             id: "1"),
                                    NftModel(name: "BBB",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                             rating: 2,
                                             price: 9,
                                             id: "2"),
                                    NftModel(name: "Ccc",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                             rating: 3,
                                             price: 8,
                                             id: "3"),
                                    NftModel(name: "AAA",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                             rating: 1,
                                             price: 10,
                                             id: "1"),
                                    NftModel(name: "BBB",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                             rating: 2,
                                             price: 9,
                                             id: "2"),
                                    NftModel(name: "Ccc",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                             rating: 3,
                                             price: 8,
                                             id: "3"),
                                    NftModel(name: "Ddd",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Biscuit/1.png"],
                                             rating: 4,
                                             price: 7,
                                             id: "4"),
                                    NftModel(name: "Eee",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Breena/1.png"],
                                             rating: 5,
                                             price: 6,
                                             id: "5"),
                                    NftModel(name: "Fff",
                                             imageURL: [""],
                                             rating: 1,
                                             price: 5,
                                             id: "6"),
                                    NftModel(name: "AAA",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                             rating: 1,
                                             price: 10,
                                             id: "1"),
                                    NftModel(name: "BBB",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                             rating: 2,
                                             price: 9,
                                             id: "2"),
                                    NftModel(name: "Ccc",
                                             imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                             rating: 3,
                                             price: 8,
                                             id: "3")
    ]
    
    private lazy var collectionView = createCollecionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tapBackButton))
        leftBarButton.tintColor = .ypBlackWithDarkMode
        navigationItem.leftBarButtonItem  = leftBarButton
        
        navigationItem.titleView?.tintColor = .ypBlackWithDarkMode
        navigationItem.title = "Коллекция NFT"
        
        view.backgroundColor = .ypWhiteWithDarkMode
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func createCollecionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(UsersCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        return collectionView
    }
    
    @objc
    private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func refreshCollection() {
        // TODO
        print(#function)
    }
}

extension UsersCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nfts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UsersCollectionCell.defaultReuseIdentifier,
            for: indexPath) as? UsersCollectionCell
            cell?.provide(nftData: nfts[indexPath.row], isInCart: true)
        return cell ?? UsersCollectionCell()
    }
}

extension UsersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 2*16 - 2*10) / 3, height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
