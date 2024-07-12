//
//  NetworkService.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 7/12/24.
//

import Foundation

class NetworkService { 
    let networkServiceInterface: NetworkServiceInterfaceable
    
    init(networkServiceInterface: NetworkServiceInterfaceable = NetworkServiceInterface.shared) {
        self.networkServiceInterface = networkServiceInterface
    }
}
