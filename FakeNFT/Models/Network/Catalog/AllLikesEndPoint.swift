//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//

import Foundation
struct AllLikesEndPoint: Endpoint {
    
    typealias ResponseType = ProfileLikesModel
    var path = "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/profile/1"
    
    func asNetworkRequest(dto: ProfileLikesModel?) -> NetworkRequest {
        return DefaultNetworkRequest(endpoint: URL(string: path)!)
    }
}

