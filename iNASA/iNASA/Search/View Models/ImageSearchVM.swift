//
//  ImageSearchVM.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/11/23.
//

import Foundation
import Combine
import UIKit


class ImageSearchVM: BaseVM {
    
    private var subscribers = Set<AnyCancellable>()
    @Published var keyWordSearch: String = ""
    var diffableDataSource: TableViewDiffableDataSource!
    var snapshot = NSDiffableDataSourceSnapshot<String?, Item>()
    
    override init(service: Service = ApiService()) {
        super.init()
        $keyWordSearch.receive(on: RunLoop.main)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { _ in
                self.callApiToGetSearchImage()
            })
            .store(in: &subscribers)
    }
    
    func callApiToGetSearchImage() {
        service?.request(GetSearchQuery(query: keyWordSearch), completionHandler: { items, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard self.diffableDataSource != nil else { return }
            
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([""])
            
            if let items = items {
                print(items)
                self.snapshot.appendItems(items, toSection: "")
                self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
            }
        })
    }
}
