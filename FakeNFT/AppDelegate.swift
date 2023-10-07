import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - УДАЛИТЬ ПОСЛЕ РЕАЛИЗАЦИИ ИНТЕРФЕЙСА
        let sut = CatalogDataRepository()
        sut.giveMeAllCollections() { result in
            print(result ?? "nil")
            print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
            sut.giveMeCollection(id: 1) { result in
                print(result ?? "nil")
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
