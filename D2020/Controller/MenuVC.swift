//
//  MenuVC.swift
//  D2020
//
//  Created by Macbook on 05/06/2021.
//

import UIKit
import KRProgressHUD
import Alamofire
import SDWebImage

class MenuVC: UIViewController {
    @IBOutlet weak var profileLogoImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        userProfileRequest()
        imageGesture()

    }
    func imageGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.imageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        profileLogoImage.isUserInteractionEnabled = true
        profileLogoImage.addGestureRecognizer(tapGesture)
        
    }
    @objc func imageTapped(recognizer: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "ProfileVC") as? ProfileVC
        navigationController?.pushViewController(scene!, animated: true)
    }
        func userProfileRequest(){
            KRProgressHUD.show()
            let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!) else{return}
            print(apiResponseModel.data)
            self.userNameLabel.text = apiResponseModel.data.name ?? ""


//            let imageUrl = URL(string: "\(apiResponseModel.data.photo ?? "")")
//            self.profileLogoImage.sd_setImage(with: imageUrl, completed: nil)
            KRProgressHUD.dismiss()

        }

    

}
