//
//  ModuleFactory.swift
//  FakeNFT
//
//  Created by Vitaly on 08.10.2023.
//

import Foundation
import UIKit

struct ModuleFactory {
    
    /// Создает таб тар для основного жкрана
    static func createTabBarController() -> UITabBarController {
        
        // Если процедура создания VC сложная, то нужно под нее сделать отдельную фабрику
        
        let cartVC = createViewController(vc: createCartViewController(),title:  "Корзина", image: UIImage(named: "Cart"))
        let catalogVC = createViewController(vc: createCatalogViewController(),title:  "Каталог", image: UIImage(named: "Catalog"))
        let profileVC = createViewController(vc: createProfileViewController(),title:  "Профиль", image: UIImage(named: "Profile"))
        let statisticVC = createViewController(vc: createStatisticViewController(),title:  "Статистика", image: UIImage(named: "Statistics"))
        
        let tabBar = UITabBarController()
        tabBar.tabBar.unselectedItemTintColor = UIColor.ypBlackWithDarkMode
        
        tabBar.viewControllers = [profileVC, catalogVC, cartVC, statisticVC]
        return tabBar
    }
    
    /// Создает viewController  для использоватения в Tabbar
    static func createViewController(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        
        guard let image = image else { return vc}
        vc.tabBarItem.image = image
        
        return vc
    }
    
    static func createCartViewController() -> CartViewController {
        return CartViewController()
    }
    static func createCatalogViewController() -> CatalogViewController {
        return CatalogViewController()
    }
    static func createProfileViewController() -> ProfileViewController {
        return ProfileViewController()
    }
    static func createStatisticViewController() -> StatisticViewController {
        return StatisticViewController()
    }
}
