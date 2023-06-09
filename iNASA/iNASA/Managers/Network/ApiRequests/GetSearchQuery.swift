//
//  GetSearchQuery.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/11/23.
//

import Foundation

class GetSearchQuery: ApiRequest<[Item]> {
    
    init(query: String) {
        super.init(endpoint: .getNASAImagesFor(search: query))
        parser = { response in
            return response.items
        }
    }
}
