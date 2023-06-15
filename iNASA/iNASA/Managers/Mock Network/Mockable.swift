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


/// This protocol is utilized to load mock data
protocol Mockable: AnyObject {
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                type: T.Type,
                                completion: @escaping (Result<T, Error>) -> Void)
    
    func loadJsonData(filename: String, extensionType: FileExtensionType) -> Data?
}

extension Mockable {
    
    func loadJson<T: Decodable>(filename: String, extensionType: FileExtensionType, type: T.Type,  completion: @escaping (Result<T, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: filename, ofType: extensionType.rawValue) else {
            fatalError("Failed to load Json file.")
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let type = Response.self
            if let decodedObject = try JSONDecoder().decode(type, from: data).collection.items as? T {
                completion(.success(decodedObject))                
            }
            
        } catch {
            print("❌ \(error)")
            fatalError("Failed to decoded the Json.")
        }
    }
    
    func loadJsonData(filename: String, extensionType: FileExtensionType) -> Data? {
        guard let path = Bundle.main.path(forResource: filename, ofType: extensionType.rawValue) else {
            fatalError("Failed to load Json file.")
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            return data
        } catch {
            print("❌ \(error)")
            fatalError("Failed to download Json data.")
        }
    }
}
