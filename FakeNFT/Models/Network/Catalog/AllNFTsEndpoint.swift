import Foundation

struct AllNFTsEndpoint: Endpoint {
    typealias ResponseType = [NFTModel]
    
    var path = "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/nft"

    func asNetworkRequest(dto: [NFTModel]?) -> NetworkRequest {
        return DefaultNetworkRequest(endpoint: URL(string: path)!)
    }
}
