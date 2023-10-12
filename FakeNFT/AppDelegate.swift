import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - УДАЛИТЬ ПОСЛЕ РЕАЛИЗАЦИИ ИНТЕРФЕЙСА
//        let sut = CatalogDataProvider()
//        print(sut.giveMeAllNFTs())
//        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
//        print(sut.giveMeAllLikes() ?? "nil")
//        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
//        sut.setLikes(likes: ["666", "999"])
//        print(sut.giveMeAllLikes() ?? "nil")
//        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
//        print(sut.giveMeCollection(withID: "1"))
//        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
//        print(sut.giveMeNft(withID: "1"))
//        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
        
        let sut = NFTCollectionsDataSource(dataProvider: CatalogDataProvider())
        print(sut.sortCollectionsByNFTQuantity())
        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
        print(sut.sortCollectionsByNFTQuantity(inOrder: .descending))
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
