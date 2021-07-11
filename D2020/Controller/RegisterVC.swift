//
//  RegisterVC.swift
//  D2020
//
//  Created by Macbook on 11/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class RegisterVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 300)

     }
    func registerNewUser(){
        KRProgressHUD.show()
        let name = nameTextField.text
        let phone = phoneTextField.text
        let mail = mailTextField.text
        let address = addressTextField.text
        let password = passwordTextField.text
        let passwordConfirmation = passwordConfirmationTextField.text
        
        let requestParameters = ["name": name ?? "","mobile": phone ?? "","address": address ?? "","email": mail ?? "","password": password ?? ""]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/register"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request("https://4rents.net/dashboard/api/user/register", method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage:"تم التسجيل")
                }else{
//                    KRProgressHUD.showError(withMessage: "كلمة المرور القديمة غير صحيحة")
                }
                
            }
    }
                
    
    @IBAction func onNextTextField(_ sender: Any) {
        if nameTextField.text!.isEmpty || phoneTextField.text!.isEmpty || mailTextField.text!.isEmpty || addressTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            
            // red placeholders
            nameTextField.attributedPlaceholder = NSAttributedString(string: "enter your name".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            phoneTextField.attributedPlaceholder = NSAttributedString(string: "enter your mobile".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            mailTextField.attributedPlaceholder = NSAttributedString(string: "enter your email".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            addressTextField.attributedPlaceholder = NSAttributedString(string: "enter your address".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "enter your Password".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])

            
        }else{
            registerNewUser()
        }
    }
    
    

}
