//
//  ApiService.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import Foundation
import Combine


typealias FutureCompletion<T> = Future<T, Error>

protocol Service {
    func request<T: Decodable>(_ resource: Any?) -> FutureCompletion<T>
}

class ApiService: Service {
    private(set) var session: URLSession?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ resource: Any?) -> FutureCompletion<T> {
        // Create request body
        // handle task & return promise
        return Future<T, Error> { [weak self] promise in
            guard let self = self else { return }
            
            // create data task 
        }
    }
}
