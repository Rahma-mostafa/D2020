//
//  TableViewCell.swift
//  D2020
//
//  Created by Macbook on 29/05/2021.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
