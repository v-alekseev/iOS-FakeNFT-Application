import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - УДАЛИТЬ ПОСЛЕ РЕАЛИЗАЦИИ ИНТЕРФЕЙСА
        let sut = CatalogDataProvider()
//        let ep  =  AllCollectionsEndpoint()
//        sut.giveMeData(using: ep) { result in
//            print(result ?? "nil")
//            print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
//            let ep = SingleCollectionEndpoint(id: 1)
//            sut.giveMeData(using: ep) { result in
//                print(result ?? "nil")
//            }
//        }
        print(sut.giveMeAllLikes() ?? "nil")
        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
        sut.setLikes(likes: [])
        print(sut.giveMeAllLikes() ?? "nil")
        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
