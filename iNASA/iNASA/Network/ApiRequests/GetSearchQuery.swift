//
//  GetSearchQuery.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/11/23.
//

import Foundation

class GetSearchQuery: ApiRequest<[Items]> {
    
    init(query: String) {
        super.init(endpoint: .getNASAImagesFor(search: query), method: .get)
        parser = { response in
            return response.items
        }
    }
}
