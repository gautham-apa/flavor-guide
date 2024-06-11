//
//  HTTPClient.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T:Decodable>(request: NetworkRequestible, responseModelType: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T:Decodable>(request: NetworkRequestible, responseModelType: T.Type) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryParams
        
        guard let url = urlComponents.url else {
            return .failure(.urlBuildingFailed)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noReponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModelType, from: data) else {
                    return .failure(.jsonDecodeFailed)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                print("Unhandled HTTP Status. \(response.statusCode)")
                return .failure(.unhandledHTTPStatus)
            }
        } catch(let error) {
            print("Unknown error occurred making network call. \(error)")
            return .failure(.unknown)
        }
    }
}
