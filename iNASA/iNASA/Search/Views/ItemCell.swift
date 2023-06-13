//
//  ItemCell.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/12/23.
//

import UIKit
import Kingfisher

struct ItemCellModel {
    var imageURL: URL?
    var title: String?
    var description: String?
}

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    var model: ItemCellModel? {
        didSet {
            setup()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        itemImageView.kf.cancelDownloadTask()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.layer.cornerRadius = 8
    }
    
    func setup() {
        guard
            let model = model,
            let imageURL = model.imageURL,
            let title = model.title
        else { return }
        
        titleLabel.text = title
        itemImageView.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "photo"), options: [.transition(.fade(1)), .cacheOriginalImage])
    }
}
