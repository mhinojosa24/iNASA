//
//  Item.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/14/23.
//

import Foundation


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
