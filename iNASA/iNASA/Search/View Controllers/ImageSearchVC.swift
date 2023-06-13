//
//  ImageSearchVC.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import UIKit
import Combine

class TableViewDiffableDataSource: UITableViewDiffableDataSource<String?, Item> {}

class ImageSearchVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Published Variables
    @Published var keyStroke: String = ""
    
    // MARK: - Constants & Variables
    let viewModel = ImageSearchVM()
    var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setupObservers()
    }
    
    func configureTableView() {
        let itemCell = UINib(nibName: String(describing: ItemCell.self), bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: ItemCell.reuseIdentifier)
    }
    
    private func setupObservers() {
        $keyStroke.receive(on: RunLoop.main)
            .sink { keyWordValue in
                print(keyWordValue)
            }
            .store(in: &subscribers)
    }
}

extension ImageSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyStroke = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.keyStroke = ""
    }
}
