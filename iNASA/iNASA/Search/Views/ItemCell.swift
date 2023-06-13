//
//  ItemCell.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/12/23.
//

import UIKit

class ItemCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
