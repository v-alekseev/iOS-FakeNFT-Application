//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//

import Foundation
struct PostLikesEndpoint: NetworkRequest {
 
    let endpoint = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/profile/1")
    let httpMethod: HttpMethod = .put
    let dto: Encodable
    
    init(dto: [String]) {
        self.dto = dto
    }
}

