import Foundation
struct UserModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [NFTModel]
    let rating: String
    let id: String
}
