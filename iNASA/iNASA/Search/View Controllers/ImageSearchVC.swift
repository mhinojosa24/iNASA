//
//  ImageSearchVC.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import UIKit

class tableViewDiffableDataSource: UITableViewDiffableDataSource<String?, Item> {}

class ImageSearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ImageSearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        let itemCell = UINib(nibName: String(describing: ItemCell.self), bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: ItemCell.reuseIdentifier)
    }
}
