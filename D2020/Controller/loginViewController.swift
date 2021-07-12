//
//  loginViewController.swift
//  D2020
//
//  Created by Macbook on 30/05/2021.
//

import UIKit

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSigninBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as? SigninVC
        navigationController?.pushViewController(scene!, animated: true)
    }
    
    
}
