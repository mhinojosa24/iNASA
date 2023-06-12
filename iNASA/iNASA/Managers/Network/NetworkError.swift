//
//  NetworkError.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case decodingError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .decodingError:
            return NSLocalizedString("Value was not found", comment: "Decoding error")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
