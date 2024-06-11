//
//  NetworkRequestible.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

protocol NetworkRequestible {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryParams: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension NetworkRequestible {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "themealdb.com"
    }
}
