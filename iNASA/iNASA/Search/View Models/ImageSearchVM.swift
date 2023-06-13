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
    var tableViewDataSource: [ItemCellModel]?
    
    func callApiToGetSearch(image query: String) {
        service?.request(GetSearchQuery(query: query), completionHandler: { items, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let items = items {
                items.compactMap({ ItemCellModel(imageURL: $0.links?.first?.href, title: $0.data?.first?.title, description: $0.data?.first?.description) }).forEach({ item in
                    self.tableViewDataSource?.append(item)
                })
            }
        })
    }
}
