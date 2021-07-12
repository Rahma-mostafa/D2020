//
//  ContactUsVC.swift
//  D2020
//
//  Created by Macbook on 12/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class ContactUsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var msgTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
        
    }
    func sendMsg(){
        KRProgressHUD.show()
        let name = nameTextField.text
        let phone = phoneTextField.text
        let mail = mailTextField.text
        let msg = msgTextField.text
        
        let requestParameters = ["name": name ?? "","phone": phone ?? "","email": mail ?? "","message": msg ?? ""]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/contact_us"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage:"تم الارسال")
                }else{
//                    KRProgressHUD.showError(withMessage: "كلمة المرور القديمة غير صحيحة")
                }
                
            }
    }
    

    @IBAction func onSentBtnTapped(_ sender: Any) {
        if nameTextField.text!.isEmpty || phoneTextField.text!.isEmpty || mailTextField.text!.isEmpty || msgTextField.text!.isEmpty  {
            
            // red placeholders
            nameTextField.attributedPlaceholder = NSAttributedString(string: "enter your name".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            phoneTextField.attributedPlaceholder = NSAttributedString(string: "enter your mobile".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            mailTextField.attributedPlaceholder = NSAttributedString(string: "enter your email".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            msgTextField.attributedPlaceholder = NSAttributedString(string: "enter your message".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])

            
        }else{
            sendMsg()
        }    }
    

}
