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
    var parser: (Collection) -> T?
    
    init(endpoint: EndPoint, method: HTTPMethod) {
        self.endpoint = endpoint
        self.method = method
        self.parser = { _ in
            nil
        }
    }
}
