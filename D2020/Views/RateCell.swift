//
//  RateCell.swift
//  D2020
//
//  Created by Macbook on 17/06/2021.
//

import UIKit
import Cosmos

class RateCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var commentLAbel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.borderWidth = 1
        self.userImage.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
