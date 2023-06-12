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
            
            session?.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else { throw NetworkError.responseError }
                    
                    return data
                }
                .decode(type: Response.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: {
                    guard let value = resource.parser($0.collection) else {
                        print("Oops something went wrong!!!!")
                        return
                    }
                    promise(.success(value))
                })
                .store(in: &self.cancellable)
        }
    }
    
    func configureApiRequest<T>(_ resource: ApiRequest<T>) -> URLRequest {
        var request = URLRequest(url: resource.endpoint.url)
        return request
    }
}
