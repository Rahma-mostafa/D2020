//
//  SectionsCell.swift
//  D2020
//
//  Created by Macbook on 10/06/2021.
//

import UIKit

class SectionsCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var pathImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        backView.layer.shadowRadius = 8
        backView.layer.shadowOpacity = 0.4
        backView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
