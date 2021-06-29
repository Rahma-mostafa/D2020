//
//  MenuVC.swift
//  D2020
//
//  Created by Macbook on 05/06/2021.
//

import UIKit

class MenuVC: UIViewController {
    @IBOutlet weak var profileLogoImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageGesture()

    }
    func imageGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.imageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        profileLogoImage.isUserInteractionEnabled = true
        profileLogoImage.addGestureRecognizer(tapGesture)
        
    }
    @objc func imageTapped(recognizer: UITapGestureRecognizer){
        print("hello")
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "ProfileVC") as? ProfileVC
        navigationController?.pushViewController(scene!, animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
