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
        let getSearchImageRequest = GetSearchQuery(query: query)
        
        service?.request(getSearchImageRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished!!")
                }
            }, receiveValue: { [weak self] searchResult in
                guard let self = self else { return }
                self.items = searchResult
                print(items)
            })
            .store(in: &cancellables)
    }
}
