//
//  PlacesCell.swift
//  D2020
//
//  Created by Macbook on 01/06/2021.
//

import UIKit

class PlacesCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
        categoryImage.layer.cornerRadius = 8
    }

}
