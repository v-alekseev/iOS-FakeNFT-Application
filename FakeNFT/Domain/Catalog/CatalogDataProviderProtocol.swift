import Foundation
protocol CatalogDataProviderProtocol {
    func giveMeAllLikes() -> ProfileLikesModel?
    func setLikes(likes: [String])
    func giveMeAllCollections() -> [CollectionModel]
    func giveMeCollection(withID id: String) -> CollectionModel?
    func giveMeAllNFTs() -> [NFTModel]
    func giveMeNft(withID id: String) -> NFTModel?
}
