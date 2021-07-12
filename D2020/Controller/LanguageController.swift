//
//  LanguageController.swift
//  D2020
//
//  Created by Macbook on 29/05/2021.
//

import UIKit
import Alamofire
import KRProgressHUD



class LanguageController: BaseController {
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
    }
  

    
    @IBAction func onApplayBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as? SigninVC
        navigationController?.pushViewController(scene!, animated: true)
    }
    


}


