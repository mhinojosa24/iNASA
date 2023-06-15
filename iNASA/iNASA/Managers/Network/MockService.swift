//
//  MockService.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/15/23.
//

import Foundation

class MockService: Service, Mockable {
    func request<T: Decodable>(_ resource: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)  {
        return loadJson(filename: "MockData",
                        extensionType: .json,
                        type: T.self) { result in
            switch result {
            case .success(let items):
                completionHandler(items, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
