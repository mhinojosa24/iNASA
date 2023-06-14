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
    var shouldShowEmptyState: Bool = true
    
    func callApiToGetSearchImage(query: String) {
        if !query.isEmpty {
            service?.request(GetSearchQuery(query: query), completionHandler: { items, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let items = items {
                    self.updateDiffableDataSource(with: items)
                }
            })
        } else {
            self.updateDiffableDataSource(with: [Item]())
        }
    }
    
    func updateDiffableDataSource(with items: [Item]) {
        DispatchQueue.main.async {
            guard self.diffableDataSource != nil else { return }
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([""])
            self.snapshot.appendItems(items, toSection: "")
            self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
