import Foundation

struct CollectionsRequest: NetworkRequest {
    var id: Int? = nil
    var endpoint: URL? {
        let appendix = id != nil ? "/\(id!)" : ""
        return URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/collections\(appendix)")
    }
    
    init(id: Int? = nil) {
        self.id = id
    }
}
