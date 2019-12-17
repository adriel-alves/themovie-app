//
//  APIError.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

enum APIError: Error {
//    case requestFailed(reason: String?)
//    case jsonConversionFailure
//    case invalidData
//    case responseUnsuccessful
//    case jsonParsingFailure
//    case requestCancelled
    case failedToCreateRequest
}

extension APIError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case
        .failedToCreateRequest:
            return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}



