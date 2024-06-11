//
//  RequestError.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

enum RequestError: Error {
    case jsonDecodeFailed
    case urlBuildingFailed
    case noReponse
    case unauthorized
    case unhandledHTTPStatus
    case unknown
    
    var message: String {
        switch self {
        case .jsonDecodeFailed:
            return "JSON decode failed"
        case .urlBuildingFailed:
            return "URL building failed"
        case .noReponse:
            return "No response received"
        case .unauthorized:
            return "Unauthorized"
        case .unhandledHTTPStatus:
            return "Unhandled HTTP status code"
        case .unknown:
            return "Unknown error occurred. Try again later"
        }
    }
}
