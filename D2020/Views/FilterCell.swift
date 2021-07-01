//
//  FilterCell.swift
//  D2020
//
//  Created by Macbook on 01/07/2021.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
