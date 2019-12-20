//
//  APIError.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

enum APIError: Error {
    case failedToCreateRequest
    case invalidURL
    case requestFailed
    case decodingFailure
    case taskError(error: Error)
    case noRespose
    case noData
    case resposeStatusCode(code: Int)
    case invalidJSON
    
}

extension APIError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case
        .failedToCreateRequest:
            return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        case
        .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case
        .requestFailed:
            return NSLocalizedString("Request Failed", comment: "")
        case
        .decodingFailure:
            return NSLocalizedString("Decoding Failuer", comment: "")
        case .taskError(let error):
            return NSLocalizedString("Task Error \(error)", comment: "")
        case .noRespose:
            return NSLocalizedString("No Response", comment: "")
        case .noData:
            return NSLocalizedString("No Data", comment: "")
        case .resposeStatusCode(let code):
            return NSLocalizedString("Status Code \(code)", comment: "")
        case .invalidJSON:
            return NSLocalizedString("Invalid JSON", comment: "")
        }
    }
}


