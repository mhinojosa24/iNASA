//
//  EndPoint.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/10/23.
//

import Foundation


/// This struct is an endpoint factory
struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.main.infoDictionary?["SERVER_URL"] as? String ?? ""
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension EndPoint {
    static func getNASAImagesFor(search: String) -> Self {
        EndPoint(path: "/search", queryItems: [
            .init(name: "q", value: search),
            .init(name: "media_type", value: "image")
        ])
    }
    
    static func getMockSearchFor(query: String) -> Self {
        EndPoint(path: "/search", queryItems: [
            .init(name: "q", value: query),
            .init(name: "media_type", value: "image")
        ])
    }
}
