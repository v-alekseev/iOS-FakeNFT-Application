import Foundation
struct CollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/collections")
    }
}
