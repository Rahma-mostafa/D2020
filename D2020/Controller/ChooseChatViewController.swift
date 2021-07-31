//
//  ChooseChatViewController.swift
//  D2020
//
//  Created by Macbook on 31/07/2021.
//

import UIKit

class ChooseChatViewController: UIViewController {
    var type = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func navtoChat(){
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "AllUserChatsVC") as!  AllUserChatsVC
        scene.type = self.type
        navigationController?.pushViewController(scene, animated: true)
    }
    @IBAction func onAdmin(_ sender: Any) {
        self.type = "admin"
        let vc = singleUserMessageVC()
        vc.title = "chat"
        vc.type = self.type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onUserBtnTapped(_ sender: Any) {
        self.type = "owner"
        navtoChat()
    }
    
    @IBAction func onDelegateBtn(_ sender: Any) {
        self.type = "delegate"
        navtoChat()
    }
    
}
