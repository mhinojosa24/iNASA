//
//  Mockable.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/15/23.
//

import Foundation

enum FileExtensionType: String {
    case json = ".json"
}

protocol Mockable: AnyObject {
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                type: T.Type,
                                completion: @escaping (Result<T, Error>) -> Void)
}

extension Mockable {
    
    func loadJson<T: Decodable>(filename: String, extensionType: FileExtensionType, type: T.Type,  completion: @escaping (Result<T, Error>) -> Void) {
        guard let path = Bundle.main.url(forResource: filename,
                                         withExtension: extensionType.rawValue) else {
            fatalError("Failed to load Json file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data) 
            
            completion(.success(decodedObject))
        } catch {
            print("❌ \(error)")
            fatalError("Failed to decoded the Json.")
        }
    }
}
