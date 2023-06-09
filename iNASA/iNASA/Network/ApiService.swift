//
//  ApiService.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import Foundation


typealias ApiServiceHandler<T> = (T?, Error?) -> Void

protocol Service {
    func request<T>(_ request: Any?, completionHandler: ApiServiceHandler<T>)
}

class ApiService: Service {
    
    func request<T>(_ request: Any?, completionHandler: (T?, Error?) -> Void) {
        <#code#>
    }
}
