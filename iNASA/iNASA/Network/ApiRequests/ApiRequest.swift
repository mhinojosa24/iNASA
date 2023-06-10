//
//  ApiRequest.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/10/23.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}

class ApiRequest<T> {
    private(set) var endpoint: EndPoint
    private(set) var method: HTTPMethod
    private(set) var headers: [String: String]
    private(set) var parameters: [String: Any]
    
    init(endpoint: EndPoint, method: HTTPMethod, headers: [String : String] = [:], parameters: [String : Any] = [:]) {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}
