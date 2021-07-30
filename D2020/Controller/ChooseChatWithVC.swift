//
//  ChooseChatWithVC.swift
//  D2020
//
//  Created by Macbook on 29/07/2021.
//

import UIKit

class ChooseChatWithVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAdminBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "ConversationVC") as!  ConversationVC
//        scene.type = "ownerWithAdmin"
        navigationController?.pushViewController(scene, animated: true)
    }
    
    
    @IBAction func onUserBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "ConversationVC") as!  ConversationVC
        navigationController?.pushViewController(scene, animated: true)
    }
    
}
