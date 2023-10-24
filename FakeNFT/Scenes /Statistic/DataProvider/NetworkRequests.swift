//
//  NetworkRequests.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 13.10.2023.
//

import Foundation

let constantURLPart = "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/"

struct UsersRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "\(constantURLPart)users")
}

struct NftWithIdRequest: NetworkRequest {
    let nftID: String
    var endpoint: URL? = nil
    init(nftID: String) {
        self.nftID = nftID
        self.endpoint =  URL(string: "\(constantURLPart)nft/\(nftID)")
    }
}

struct ProfileRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "\(constantURLPart)profile/1")
}

struct CartRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "\(constantURLPart)orders/1")
}

//struct СartUpdateRequest: NetworkRequest {
//    var endpoint: URL? = URL(string: "\(constantURLPart)orders/1")
//    var httpMethod: HttpMethod { .put }
//    
////    var dto: Encodable?
////    init(cartIDs: [String]) {
////        self.dto = UpdateCartDto(nfts: cartIDs)
////    }
//}

