//
//  ModuleFactory.swift
//  FakeNFT
//
//  Created by Vitaly on 08.10.2023.
//

import UIKit

struct ModuleFactory {
    
    /// Создает таб тар для основного жкрана
    static func createTabBarController() -> UITabBarController {
        
        // Если процедура создания VC сложная, то нужно под нее сделать отдельную фабрику
        
        let cartVC = createViewController(vc: createCartViewController(),title:  "Корзина", image: UIImage(resource: .cart))
        let catalogVC = createViewController(vc: createCatalogViewController(),title:  "Каталог", image: UIImage(resource: .catalog))
        let profileVC = createViewController(vc: createProfileViewController(),title:  "Профиль", image: UIImage(resource: .profile))
        let statisticVC = createViewController(vc: createStatisticViewController(),title:  "Статистика", image: UIImage(resource: .statistics))
        
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
        return CatalogViewController()
    }
    static func createProfileViewController() -> UIViewController {
        return ProfileViewController()
    }
    static func createStatisticViewController() -> UIViewController {
        let dataProvider = StatisticDataProvider()
        let viewModel = StatisticViewModel(dataProvider: dataProvider)
        let viewController = StatisticViewController(viewModel)
        let navigationVC = UINavigationController(rootViewController: viewController)
        return navigationVC
    }
}
