//
//  HandlingErrorServiceStat.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 24.10.2023.
//

import Foundation

final class HandlingErrorService {
    
    static let shared = HandlingErrorService()
    
    func handlingHTTPStatusCodeError(error: Error) -> String? {
        guard let error = error as? NetworkClientError else { return nil }
        
        switch error {
        case .httpStatusCode(let code):
            switch  code {
            case 404:
                return L10n.HandlingError.error404
            case 409:
                return L10n.HandlingError.error409
            case 410:
                return L10n.HandlingError.error410
            case 429:
                return L10n.HandlingError.error429
            case 500...526:
                return L10n.HandlingError.error500526
            default:
                return L10n.HandlingError.default
            }
            
        case .parsingError:
            return L10n.HandlingError.parsingError
        case .urlRequestError:
            return  L10n.HandlingError.urlRequestError
        case .urlSessionError:
            return L10n.HandlingError.urlSessionError
        }
    }
}
