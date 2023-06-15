//
//  ImageSearchVC.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import UIKit
import Combine


class ImageSearchVC: UIViewController {
    
    struct UIConstants {
        let defaultTableViewCell = UITableViewCell()
        let cellHeight: CGFloat = 100
        let animationDelay: Double = 1.5
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateStackView: UIStackView!
    @IBOutlet weak var emptyStateImageView: UIImageView!
    
    // MARK: - Published Variables
    @Published var keyStroke: String = ""
    
    // MARK: - Constants & Variables
    let viewModel = ImageSearchVM()
    let uiConstants = UIConstants()
    var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupObservers()
    }
    
    // MARK: - User Defined Methods
    
    private func configureUI() {
        navigationController?.view.backgroundColor = .systemBackground
        let itemCell = UINib(nibName: String(describing: ItemCell.self), bundle: nil)
        tableView.delegate = self
        tableView.register(itemCell, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.rowHeight = uiConstants.cellHeight
        tableView.keyboardDismissMode = .onDrag
        let emptyStateImage = self.traitCollection.userInterfaceStyle == .dark ? UIImage(named: "emptyStateDarkMode") : UIImage(named: "emptyStateLightMode")
        self.emptyStateImageView.image = emptyStateImage
    }
    
    private func setupObservers() {
        viewModel.$shouldDisplayEmptyState.receive(on: RunLoop.main)
            .sink(receiveValue: { shouldDisplay in
                UIView.animate(withDuration: .zero) {
                    self.emptyStateStackView.isHidden = !shouldDisplay
                }
            }).store(in: &subscribers)
        
        $keyStroke.receive(on: RunLoop.main)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { keyWordValue in
                self.viewModel.callApiToGetSearchImage(query: keyWordValue)
            }).store(in: &subscribers)
        
        viewModel.diffableDataSource = TableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell else {
                return self.uiConstants.defaultTableViewCell
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

// MARK: - UITableViewDelegate

extension ImageSearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imageModel = viewModel.diffableDataSource.itemIdentifier(for: indexPath) else { return }
        
        if let imageDetailVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailVC") as? ImageDetailVC {
            imageDetailVC.viewModel.imageDetailModel = imageModel
            self.navigationController?.pushViewController(imageDetailVC, animated: false)
        }
    }
}
