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
    let items: [Item]?
}

struct Item: Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case data, links
        case nasaId = "nasa_id"
    }
    
    let data: [ImageData]?
    let links: [Links]?
    let nasaId: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nasaId)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.nasaId == rhs.nasaId
    }
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
