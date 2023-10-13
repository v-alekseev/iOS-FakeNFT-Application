
import Foundation
protocol CollectionsViewModelProtocol {
    func setSortType(sortType: SortType)
    func howManyCollections() -> Int
    func getCollection(at indexPath: IndexPath) -> CollectionModel?
    func getCollectionName(at indexPath: IndexPath) -> String
    func getCollectionImage(at indexPath: IndexPath) -> String
    func getCollectionNFTQuantity(at indexPath: IndexPath) -> Int
}
