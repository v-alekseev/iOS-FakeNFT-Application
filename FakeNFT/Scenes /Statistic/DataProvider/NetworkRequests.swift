//
//  NetworkRequests.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 13.10.2023.
//

import Foundation

struct UsersRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/users")
}

struct NftWithIdRequest: NetworkRequest {
    let nftID: String
    var endpoint: URL? = nil
    init(nftID: String) {
        self.nftID = nftID
        self.endpoint =  URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/nft/\(nftID)")
    }
}

struct ProfileRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/1")
}


//struct ActualUserRequest: NetworkRequest {
//    let userID: String
//    var endpoint: URL? = nil
//    init(userID: String) {
//        self.userID = userID
//        self.endpoint =  URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/users/\(userID)")
//    }
//}
