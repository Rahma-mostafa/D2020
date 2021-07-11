//
//  ChangePasswordVC.swift
//  D2020
//
//  Created by Macbook on 10/07/2021.
//

import UIKit
import KRProgressHUD
import Alamofire

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func blurView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blueView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blueView.addSubview(blurEffectView)
    }
    func postNewPassword(){
        KRProgressHUD.show()
        let oldPassword = oldPasswordTextField.text
        let newPassword = newPasswordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        let requestParameters = ["old_password": oldPassword ?? "","password": newPassword ?? "", "password_confirmation": confirmPassword ?? ""]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/profile/update_password"
        print("URL : \(apiURLInString)")
        
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request("https://4rents.net/dashboard/api/user/profile/update_password", method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
//                let jsonConverter = JSONDecoder()
//                guard let apiResponseModel = try? jsonConverter.decode(UpdatePassword.self, from: result.data!) else{return}
                
                
                KRProgressHUD.dismiss()
                
            }
    }
                

    @IBAction func onConfirmBtnTapped(_ sender: Any) {
        if oldPasswordTextField.text!.isEmpty || newPasswordTextField.text!.isEmpty || confirmPasswordTextField.text!.isEmpty{
            
            // red placeholders
            oldPasswordTextField.attributedPlaceholder = NSAttributedString(string: "enter Old Password".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            newPasswordTextField.attributedPlaceholder = NSAttributedString(string: "enter new Password".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "confirm your password".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])

            
        }else{
            postNewPassword()
        }
        
    }
    
}
