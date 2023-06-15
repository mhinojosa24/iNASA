//
//  ImageDetailVC.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/14/23.
//

import Foundation
import UIKit
import Kingfisher


class ImageDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let viewModel = ImageDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = nil
        imageView.kf.cancelDownloadTask()
        titleLabel.textColor = .none
        descriptionLabel.textColor = .none
        
        if let imageURLString = viewModel.imageDetailModel?.links?.first?.href, let imageURL = URL(string: imageURLString) {
            imageView.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
        }
        
        if let title = viewModel.imageDetailModel?.data?.first?.title {
            titleLabel.text = title
        }
        
        if let description = viewModel.imageDetailModel?.data?.first?.description {
            descriptionLabel.text = description
        }
    }
}
