import Foundation

struct CollectionModel: Codable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [NFTModel]
    let description: String
    let id: String
}
