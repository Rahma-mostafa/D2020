//
//  SubCategoryCell.swift
//  D2020
//
//  Created by Macbook on 12/06/2021.
//

import UIKit
import Cosmos
class SubCategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rateView: CosmosView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var subcatagoryBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onSubcategoryBtnTapped(_ sender: Any) {
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
    }
}
