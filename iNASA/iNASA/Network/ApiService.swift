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
    func request<T: Decodable>(_ resource: ApiRequest<T>) -> FutureCompletion<T>
}

class ApiService: Service {
    private(set) var session: URLSession?
    private(set) var cancellable = Set<AnyCancellable>()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ resource: ApiRequest<T>) -> FutureCompletion<T> {
        let request = configureApiRequest(resource)
        
        return Future<T, Error> { [weak self] promise in
            guard let self = self else { return }
            
            // create data task
        }
    }
    
    func configureApiRequest<T>(_ resource: ApiRequest<T>) -> URLRequest {
        var request = URLRequest(url: resource.endpoint.url)
        request.httpMethod = resource.method.rawValue
        request.allHTTPHeaderFields = resource.headers
        return request
    }
}
