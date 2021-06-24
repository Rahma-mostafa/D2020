//
//  ProfileVC.swift
//  D2020
//
//  Created by Macbook on 23/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class ProfileVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 500)

     }
    


}
