//
//  APIError.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

enum APIError: Error {
    case decodingFailure
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
    
}

extension APIError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case
        .decodingFailure:
            return NSLocalizedString("Decoding Failuer", comment: "")
        case .taskError(let error):
            return NSLocalizedString("Task Error \(error)", comment: "")
        case .noResponse:
            return NSLocalizedString("No Response", comment: "")
        case .noData:
            return NSLocalizedString("No Data", comment: "")
        case .responseStatusCode(let code):
            return NSLocalizedString("Status Code \(code)", comment: "")
        case .invalidJSON:
            return NSLocalizedString("Invalid JSON", comment: "")
        }
    }
}


