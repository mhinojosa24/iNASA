//
//  ImageSearchVC.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import UIKit

class ImageSearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ImageSearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callApiToGetSearch(image: "Mars")
    }
}
