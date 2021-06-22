//
//  CategoriesCell.swift
//  D2020
//
//  Created by Macbook on 11/06/2021.
//

import UIKit

class CategoriesCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 7
        categoryImageView.layer.cornerRadius = 7
        
    }

}
