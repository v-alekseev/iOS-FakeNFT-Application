import Foundation

class NFTCollectionsDataSource {
    private var collections: [CollectionModel]
    
    init(dataProvider: CatalogDataProviderProtocol) {
        collections = dataProvider.giveMeAllCollections()
    }
    
    func giveMeAllCollections() -> [CollectionModel] {
        return collections
    }
    
    func sortCollectionsByName(inOrder: SortCases = .ascending ) -> [CollectionModel] {
        switch inOrder {
        case .ascending:
            return collections.sorted { $0.name < $1.name }
        case .descending:
            return collections.sorted { $0.name > $1.name }
        }
    }
    
    func sortCollectionsByNFTQuantity(inOrder: SortCases = .ascending) -> [CollectionModel] {
        switch inOrder {
        case .ascending:
            return collections.sorted { $0.nfts.count < $1.nfts.count }
        case .descending:
            return collections.sorted { $0.nfts.count > $1.nfts.count }
        }
    }
    
    
}
