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
    @IBOutlet weak var aboutImageView: UIImageView!
    @IBOutlet weak var languageStackView: UIStackView!
    
    @IBOutlet weak var techinicalSportImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        userProfileRequest()
        imageGesture()
        aboutGesture()
        contactGesture()
//        languageGesture()

    }
    func imageGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.imageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        profileLogoImage.isUserInteractionEnabled = true
        profileLogoImage.addGestureRecognizer(tapGesture)
        
    }
    func aboutGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.aboutImageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        aboutImageView.isUserInteractionEnabled = true
        aboutImageView.addGestureRecognizer(tapGesture)
    }
    func contactGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.contactImageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        techinicalSportImageView.isUserInteractionEnabled = true
        techinicalSportImageView.addGestureRecognizer(tapGesture)
    }
    
//    func languageGesture(){
//        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.languageTapped(recognizer:)))
//        tapGesture.numberOfTapsRequired = 1
//        languageStackView.isUserInteractionEnabled = true
//        languageStackView.addGestureRecognizer(tapGesture)
//    }
    

    @objc func imageTapped(recognizer: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "ProfileVC") as? ProfileVC
        navigationController?.pushViewController(scene!, animated: true)
    }
    @objc func aboutImageTapped(recognizer: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "AboutVC") as? AboutVC
        navigationController?.pushViewController(scene!, animated: true)
    }
    @objc func contactImageTapped(recognizer: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "ContactUsVC") as? ContactUsVC
        navigationController?.pushViewController(scene!, animated: true)
    }
        
//    @objc func languageTapped(recognizer: UITapGestureRecognizer){
//        let alert = UIAlertController(title: "اللغة", message: "اختيار اللغة", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "العربية", style: UIAlertAction.Style.default, handler: {[weak self] _ in
//            UserDefaults.standard.setValue("ar", forKey: "app_lang")
////            self?.restartApp()
//        }))
//
//        alert.addAction(UIAlertAction(title: "الانجليزية", style: UIAlertAction.Style.default, handler:{[weak self] _ in
//            UserDefaults.standard.setValue("en", forKey: "app_lang")
////            self?.restartApp()
//        }))
//        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
//    }
    
//    private func restartApp(){
//        let window = UIWindow.key
//        let storyboard = UIStoryboard.init(name: "Auth", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController()
//        let appLanguage = UserDefaults.standard.string(forKey: "app_lang") ?? "ar"
//        let appLanguageHandler = AppLanguageHandler()
//        appLanguageHandler.setAppLang(with: appLanguage)
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
//    }
        func userProfileRequest(){
            KRProgressHUD.show()
            let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!) else{return}
            print(apiResponseModel.data)
            self.userNameLabel.text = apiResponseModel.data.name ?? ""
            let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(apiResponseModel.data.photo ?? "")"
            self.profileLogoImage.sd_setImage(with: URL(string: imageUrl))
            KRProgressHUD.dismiss()

        }

    

}
