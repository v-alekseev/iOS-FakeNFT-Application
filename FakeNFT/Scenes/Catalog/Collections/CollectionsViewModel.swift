import Foundation
final class CollectionsViewModel: CollectionsViewModelProtocol {
    func howManyCollections() -> Int {
        return 0
    }
    
    func getCollection(at indexPath: IndexPath) -> CollectionModel? {
        return nil
    }
    
    func getCollectionName(at indexPath: IndexPath) -> String {
        return ""
    }
    
    func getCollectionImage(at indexPath: IndexPath) -> String {
        return ""
    }
    
    func getCollectionNFTQuantity(at indexPath: IndexPath) -> Int {
        return 0
    }
    
    
}
