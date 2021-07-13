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
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var profileLogoImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var aboutImageView: UIImageView!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var techinicalSportImageView: UIImageView!
    @IBOutlet weak var shareStackView: UIStackView!
    @IBOutlet weak var logoutStackView: UIStackView!
    @IBOutlet weak var cityStackView: UIStackView!
    @IBOutlet weak var storesStackView: UIStackView!
    @IBOutlet weak var delegateStckView: UIStackView!
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var contactStackView: UIStackView!
    @IBOutlet weak var aboutStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileRequest()
        profileGesture()
        aboutGesture()
        contactGesture()
        shareGesture()
//        languageGesture()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
    }
 
    func profileGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.imageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        profileStackView.isUserInteractionEnabled = true
        profileStackView.addGestureRecognizer(tapGesture)
        
    }
    func aboutGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.aboutImageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        aboutStackView.isUserInteractionEnabled = true
        aboutStackView.addGestureRecognizer(tapGesture)
    }

    func shareGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.shareTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        shareStackView.isUserInteractionEnabled = true
        shareStackView.addGestureRecognizer(tapGesture)
    }
        
    
    func contactGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.contactImageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        contactStackView.isUserInteractionEnabled = true
        contactStackView.addGestureRecognizer(tapGesture)
    }
    func logoutGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MenuVC.logoutTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        logoutStackView.isUserInteractionEnabled = true
        logoutStackView.addGestureRecognizer(tapGesture)
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
    @objc func shareTapped(recognizer: UITapGestureRecognizer){
        let activityVC = UIActivityViewController(activityItems:["www.google.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    @objc func logoutTapped(recognizer: UITapGestureRecognizer){
        callingLogoutAPI()
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
    func callingLogoutAPI(){
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue)
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as? SigninVC
        self.navigationController?.popToViewController(scene!, animated: true)
//        KRProgressHUD.show()
//        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
//        let headers = ["Authorization":"Bearer \(token)"]
//        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/profile"
//        guard let apiURL = URL(string: apiURLInString) else{ return }
//        Alamofire
//            .request(apiURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
//            .response {[weak self] result in
//                if result.error != nil{
//                    KRProgressHUD.showError(withMessage: "عطل بالانترنت")
//                }else{
//                    if result.response?.statusCode == 200{
//                        UserDefaults.standard.removeObject(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue)
//                        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//                        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as? SigninVC
//                        self?.navigationController?.popToViewController(scene!, animated: true)
//                    }
//                    KRProgressHUD.dismiss()
//                }
//            }
    }
    
    // user data
        func userProfileRequest(){
            KRProgressHUD.show()
            let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!) else{return}
            print(apiResponseModel.data)
            self.userNameLabel.text = apiResponseModel.data.name ?? ""
            self.nickNameLabel.text = apiResponseModel.data.typ ?? ""
            let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(apiResponseModel.data.photo ?? "")"
            self.profileLogoImage.sd_setImage(with: URL(string: imageUrl))
            KRProgressHUD.dismiss()

        }

    

}
