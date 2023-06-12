//
//  Collection.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/10/23.
//

import Foundation

struct Response: Decodable {
    let collection: Collection
}

struct Collection: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let data: [ImageData]
    let links: [Links]
}

struct ImageData: Decodable {
    enum CodingKeys: String, CodingKey {
        case title, description
        case dateCreated = "date_created"
    }
    
    let title: String
    let description: String
    let dateCreated: String
}

struct Links: Decodable {
    let href: String
}
