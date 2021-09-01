//
//  FullImageVC.swift
//  D2020
//
//  Created by Macbook on 01/09/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class FullImageVC: UIViewController {
    var imageUrl = ""

    @IBOutlet weak var fullImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullImageView.sd_setImage(with: URL(string: self.imageUrl ))


    }

    

    

}
