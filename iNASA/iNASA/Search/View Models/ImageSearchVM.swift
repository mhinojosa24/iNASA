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

    // MARK: - Variables
    var diffableDataSource: TableViewDiffableDataSource!
    var snapshot = NSDiffableDataSourceSnapshot<String?, Item>()
    
    @Published var shouldDisplayEmptyState: Bool = true
    
    // MARK: - User Defined Methods
    
    /// Method is to ping NASA API for search image based on query
    /// - Parameter query: String
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
    
    /// Method is called to update diffable datasource
    /// - Parameter items: Array of Items
    func updateDiffableDataSource(with items: [Item]) {
        DispatchQueue.main.async {
            self.shouldDisplayEmptyState = items.isEmpty
            guard self.diffableDataSource != nil else { return }
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([""])
            self.snapshot.appendItems(items, toSection: "")
            self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
}
