//
//  ApiRequest.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/10/23.
//

import Foundation


class ApiRequest<T> {
    private(set) var endpoint: EndPoint
    var parser: (Collection) -> T?
    
    init(endpoint: EndPoint) {
        self.endpoint = endpoint
        self.parser = { _ in
            nil
        }
    }
}
