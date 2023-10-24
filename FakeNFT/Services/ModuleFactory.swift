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
        
        let cartVC = createViewController(vc: createCartViewController(),title:  L10n.Tabbar.basket, image: UIImage(resource: .cart))
        let catalogVC = createViewController(vc: createCatalogViewController(),title:  L10n.Tabbar.catalog, image: UIImage(resource: .catalog))
        let profileVC = createViewController(vc: createProfileViewController(),title:  L10n.Tabbar.profile, image: UIImage(resource: .profile))
        let statisticVC = createViewController(vc: createStatisticViewController(),title:  L10n.Tabbar.stats, image: UIImage(resource: .statistics))
        
        let tabBar = UITabBarController()
        tabBar.tabBar.unselectedItemTintColor = UIColor.ypBlackWithDarkMode
        tabBar.tabBar.backgroundColor = .ypWhiteWithDarkMode
        
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
    
    static func createCartViewController() -> UIViewController {
        return CartViewController()
    }
    
    static func createCatalogViewController() -> UIViewController {
        let viewController = CollectionsViewController()
        let navController = UINavigationController(rootViewController: viewController)

        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true

        return navController
    }
    
    static func createProfileViewController() -> UIViewController {
        return ProfileViewController()
    }
    static func createStatisticViewController() -> UIViewController {
        return StatisticViewController()
    }
}
