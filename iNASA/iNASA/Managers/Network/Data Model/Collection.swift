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
    }
    
    let data: [ImageData]?
    let links: [Links]?
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(getItemId())
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.getItemId() == rhs.getItemId()
    }
    
    private func getItemId() -> String? {
        guard let data = data, let nasaId = data.first?.nasaId else { return nil }
        return nasaId
    }
}

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

struct Links: Decodable {
    let href: String
}
