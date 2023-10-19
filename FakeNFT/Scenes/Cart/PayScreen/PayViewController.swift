//
//  PayViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 18.10.2023.
//

import UIKit
import ProgressHUD

final class PayViewController: UIViewController {
    
    let termOfUseUrl = "https://yandex.ru/legal/practicum_termsofuse"
    
    // MARK: - Private Properties
    //
    
    private lazy var bottomView: UIView = {
        var view = UIView()
        view.backgroundColor = .ypLightGreyWithDarkMode
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var termsOfUseFirstLineLabel: UILabel = {
        var label = UILabel()
        let string = "Совершая покупку, вы соглашаетесь с условиями"

        label.text = string
        label.font =  UIFont.caption2
        label.textColor = .ypBlackWithDarkMode
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var termsOfUseSecondLineLabel: UILabel = {
        var label = UILabel() //UITextView()
        let string = "Пользовательского соглашения"

        label.text = string //"Оплата"
        label.font =  UIFont.caption2
        label.textColor = .ypBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Cart.paymentButtonTitle, for: .normal)
        button.titleLabel?.font =  UIFont.bodyBold
        button.setTitleColor(.ypWhiteWithDarkMode, for: .normal)
        button.backgroundColor = .ypBlackWithDarkMode
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(paymentButtonTap), for: .touchUpInside)
        return button
    }()
    
    lazy var currencyCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .ypWhiteWithDarkMode
        collectionView.allowsMultipleSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - UIViewController(*)
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteWithDarkMode
        
        guard let navBar = navigationController?.navigationBar  else { return }
        navigationItem.title = "Выберите способ оплаты"
        navBar.tintColor = .ypBlackWithDarkMode
        navBar.titleTextAttributes =  [ .font: UIFont.bodyBold]
        
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        currencyCollectionView.register(PayCollectionViewCell.self)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        termsOfUseSecondLineLabel.addGestureRecognizer(tapGesture)

        setupUI()
    }

    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            // Показ пользовательского соглашения
            let termsOfUseViewModel = WebViewViewModel()
            let termsOfUseVC = WebViewViewController(viewModel: termsOfUseViewModel, url: URL(string: termOfUseUrl))
            termsOfUseVC.modalPresentationStyle = .formSheet
            
            self.present(termsOfUseVC, animated: true)
        }
    }
     
    
    /// Функция обрабатывает нажатие на кнопку оплаты
    @objc
    private func paymentButtonTap() {
        print("paymentButtonTap")
    }
    // MARK: - Private Methods
    //
    private func setupUI() {
        view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 186),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bottomView.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -12),
            paymentButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            paymentButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -50),
            paymentButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        bottomView.addSubview(termsOfUseFirstLineLabel)
        NSLayoutConstraint.activate([
            termsOfUseFirstLineLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            termsOfUseFirstLineLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16)
        ])
        
        bottomView.addSubview(termsOfUseSecondLineLabel)
        NSLayoutConstraint.activate([
            termsOfUseSecondLineLabel.leadingAnchor.constraint(equalTo: termsOfUseFirstLineLabel.leadingAnchor),
            termsOfUseSecondLineLabel.topAnchor.constraint(equalTo: termsOfUseFirstLineLabel.bottomAnchor, constant: 4)
        ])
        
        view.addSubview(currencyCollectionView)
        
        NSLayoutConstraint.activate([
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currencyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyCollectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
        
    }
}

struct CollectionLayout {
    static let trailingOffsetCell: Double = 16
    static let leadingOffsetCell: Double = 16
    static let topOffsetCell: Double = 20
    static let heightOfCell: Double = 46
    static let spaceBetweenColumns: Double = 7
    static let spaceBetweenRows: Double = 7
    static let countOfColumsCell: Double = 2
}

extension PayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = currencyCollectionView.cellForItem(at: indexPath) as? PayCollectionViewCell
        cell?.selectCell(isSelected: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = currencyCollectionView.cellForItem(at: indexPath) as? PayCollectionViewCell
        cell?.selectCell(isSelected: false)
    }
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

extension PayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PayCollectionViewCell = currencyCollectionView.dequeueReusableCell(indexPath: indexPath)
        return cell
    }

}
