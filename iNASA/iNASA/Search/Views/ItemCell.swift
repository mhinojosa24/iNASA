//
//  ItemCell.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/12/23.
//

import UIKit

struct ItemCellModel {
    var imageURL: String?
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        
    }
    
}
