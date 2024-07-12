//
//  NetworkServiceInterface.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 7/12/24.
//

import Foundation

protocol NetworkServiceInterfaceable {
    func sendRequest <T: Decodable>(decodableType: T.Type, networkRequest: NetworkRequestible) async -> Result<T, RequestError>
}

class NetworkServiceInterface: NetworkServiceInterfaceable {
    
    static let shared = NetworkServiceInterface()
    
    private var httpClient: BaseNetworkServiceable
    
    init(httpClient: BaseNetworkServiceable = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func sendRequest <T: Decodable>(decodableType: T.Type, networkRequest: NetworkRequestible) async -> Result<T, RequestError> {
        do {
            let urlRequest = try buildURLRequest(request: networkRequest, authorized: false)
            let response = try await httpClient.sendRequest(urlRequest: urlRequest, responseModelType: decodableType)
            return handleResponse(data: response.data, urlResponse: response.response, decodableType: decodableType)
        } catch(let error) {
            print("Error occurred while fetching network data. \(error)")
            return .failure(RequestError.unknown)
        }
    }
    
    func buildURLRequest(request: NetworkRequestible, authorized: Bool) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryParams
        
        guard let url = urlComponents.url else {
            throw RequestError.urlBuildingFailed
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return urlRequest
    }

    func handleResponse<T: Decodable>(data: Data, urlResponse: HTTPURLResponse, decodableType: T.Type) -> Result<T, RequestError> {
        switch urlResponse.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(decodableType, from: data) else {
                return .failure(.jsonDecodeFailed)
            }
            return .success(decodedResponse)
        case 401:
            return .failure(.unauthorized)
        default:
            print("Unhandled HTTP Status. \(urlResponse.statusCode)")
            return .failure(.unhandledHTTPStatus)
        }
    }
}

