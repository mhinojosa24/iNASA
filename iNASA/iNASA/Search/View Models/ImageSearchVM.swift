//
//  ImageSearchVM.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/11/23.
//

import Foundation
import Combine


class ImageSearchVM: BaseVM {
    
    private var cancellables = Set<AnyCancellable>()
    var items: [Items]?
    
    func callApiToGetSearch(image query: String) {
        service?.request(GetSearchQuery(query: query), completionHandler: { items, error in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
