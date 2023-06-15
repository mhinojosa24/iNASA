//
//  ImageData.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/14/23.
//

import Foundation


struct ImageData: Decodable {
    enum CodingKeys: String, CodingKey {
        case title, description
        case dateCreated = "date_created"
        case nasaId = "nasa_id"
    }
    
    let title: String
    let description: String
    let dateCreated: String
    let nasaId: String?
}
