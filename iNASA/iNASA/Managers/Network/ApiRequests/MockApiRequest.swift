//
//  MockApiRequest.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/15/23.
//

import Foundation


class MockApiRequest: ApiRequest<[Item]> {
    
    init(query: String) {
        super.init(endpoint: .getMockSearchFor(query: query))
        parser = { response in
            return response.items
        }
    }
}
