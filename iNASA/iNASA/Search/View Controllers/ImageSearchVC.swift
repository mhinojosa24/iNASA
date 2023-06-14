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
    @IBOutlet weak var emptyStateStackView: UIStackView!
    @IBOutlet weak var emptyStateImageView: UIImageView!
    
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
    
    // MARK: - User Defined Methods
    
    private func configureTableView() {
        navigationController?.view.backgroundColor = .systemBackground
        let itemCell = UINib(nibName: String(describing: ItemCell.self), bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.rowHeight = 100
        let emptyStateImage = self.traitCollection.userInterfaceStyle == .dark ? UIImage(named: "emptyStateDarkMode") : UIImage(named: "emptyStateLightMode")
        self.emptyStateImageView.image = emptyStateImage
    }
    
    private func setupObservers() {
        $keyStroke.receive(on: RunLoop.main)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { keyWordValue in
                self.viewModel.callApiToGetSearchImage(query: keyWordValue)
                UIView.animate(withDuration: 0, delay: 1.5) {
                    self.emptyStateStackView.isHidden = !keyWordValue.isEmpty
                }
            }).store(in: &subscribers)
        
        viewModel.diffableDataSource = TableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell else {
                return UITableViewCell()
            }
            
            cell.model = model
            return cell
        })
    }
}

// MARK: - UISearchBarDelegate Methods

extension ImageSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyStroke = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.keyStroke = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
