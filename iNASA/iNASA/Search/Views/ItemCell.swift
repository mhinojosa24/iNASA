//
//  ItemCell.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/12/23.
//

import UIKit
import Kingfisher

class ItemCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var reuseIdentifier: String { String(describing: self) }
    
    var model: Item? {
        didSet {
            setup()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.textColor = .none
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
            let imageURL = URL(string: model.links?.first?.href ?? ""),
            let title = model.data?.first?.title
        else { return }
        
        titleLabel.text = title
        itemImageView.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "photo.fill"), options: [.transition(.fade(1)), .cacheOriginalImage])
    }
}
