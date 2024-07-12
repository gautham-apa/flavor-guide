//
//  HTTPClient.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

protocol BaseNetworkServiceable {
    func sendRequest<T:Decodable>(urlRequest: URLRequest, responseModelType: T.Type) async throws -> (data: Data, response: HTTPURLResponse)
}

class HTTPClient: BaseNetworkServiceable {
    func sendRequest<T:Decodable>(urlRequest: URLRequest, responseModelType: T.Type) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noReponse
            }
            return (data, response)
        } catch(let error) {
            print("Unknown error occurred making network call. \(error)")
            throw RequestError.unknown
        }
    }
}

