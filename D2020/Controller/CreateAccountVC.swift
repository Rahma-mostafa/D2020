//
//  loginViewController.swift
//  D2020
//
//  Created by Macbook on 30/05/2021.
//

import UIKit

class CreateAccountVC: UIViewController {
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSigninBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as? SigninVC
        navigationController?.pushViewController(scene!, animated: true)
    }
    @IBAction func onNewUserBtnTapped(_ sender: Any) {
        self.type = "user"
        navToRegisteration()
    }
    
    @IBAction func onNewDelegateBtnTapped(_ sender: Any) {
        self.type = "delegate"
        navToRegisteration()
    }
    @IBAction func onNewownerBtnTapped(_ sender: Any) {
        self.type = "owner"
        navToRegisteration()
    }
    func navToRegisteration(){
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        scene.type = self.type
        navigationController?.pushViewController(scene, animated: true)
    }
    
}
