//
//  ApiService.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import Foundation

// MARK: - Typealias
typealias ApiHandler<T> = (T?, Error?) -> Void
typealias ResponseHandler = (Any?, Error?) -> Void

/// This protocol is a blueprint of network methods
protocol Service {
    func request<T: Decodable>(_ resource: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)
}

/// This class handles network businesses
class ApiService: Service {
    private(set) var session: URLSession?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ resource: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>) {
        session?.request(resource.url, then: { data, response, error in
            if let error = error {
                completionHandler(nil, error)
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(nil, NetworkError.responseError)
            }
            
            self.handleResponse(data, resource: resource, handler: completionHandler)
        })
    }
    
    private func handleResponse<T>(_ data: Data?, resource: ApiRequest<T>, handler: @escaping ApiHandler<T>) {
        if let data = data {
            do {
                let response: Response = try JSONDecoder().decode(Response.self, from: data)
                handler(resource.parser(response.collection), nil)
            } catch {
                handler(nil, NetworkError.decodingError)
            }
        }
    }
}
