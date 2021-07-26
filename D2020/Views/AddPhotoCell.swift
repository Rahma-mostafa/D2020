//
//  AddPhotoCell.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onDeleteBtnTapped(_ sender: Any) {
    }


    
}
