//
//  MockService.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/15/23.
//

import Foundation


/// This class sole purpose is to mock `Service` class functionality
class MockService: Service, Mockable {
    func request<T: Decodable>(_ resource: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)  {
        return loadJson(filename: "MockData",
                        extensionType: .json,
                        type: Response.self) { result in
            switch result {
            case .success(let response):
                completionHandler(resource.parser(response.collection), nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
