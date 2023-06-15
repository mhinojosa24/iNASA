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
    case decodingDataError
    case fatalError
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
        case .decodingDataError:
            return NSLocalizedString("Value was not found", comment: "Decoding data error")
        case .fatalError:
            return NSLocalizedString("Something went wrong", comment: "Fatal error")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
    
    static func functionThatThrows() throws {
        throw NetworkError.fatalError
    }
}
