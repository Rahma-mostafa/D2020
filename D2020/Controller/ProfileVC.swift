//
//  ProfileVC.swift
//  D2020
//
//  Created by Macbook on 23/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class ProfileVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    @IBOutlet weak var userMailTextField: UITextField!
    @IBOutlet weak var passwordConfimationTextField: UITextField!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNickNameLabel: UILabel!
    @IBOutlet weak var addressTextBox: UITextField!
    var userToken: String = ""
    var citiesArray = [CitiesDataClass]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileRequest()
        changePasswordView.isHidden = true



    }


    func userProfileRequest(){
//        KRProgressHUD.show()
        let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
        let jsonConverter = JSONDecoder()
        guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!)else{return}
        print(apiResponseModel.data)
        self.userNameLabel.text = apiResponseModel.data.name ?? ""
        self.userNameTextField.text = apiResponseModel.data.name ?? ""
        self.userNickNameLabel.text = apiResponseModel.data.typ ?? ""
        self.userPhoneTextField.text = apiResponseModel.data.mobile ?? ""
        self.userMailTextField.text = apiResponseModel.data.email ?? ""
        let imageUrl = URL(string: "\(apiResponseModel.data.photo ?? "")")
        self.userImage.sd_setImage(with: imageUrl, completed: nil)
        self.addressTextBox.text = apiResponseModel.data.address ?? ""
//        self.passwordTextField.text = apiResponseModel.data
        
        
        
//        KRProgressHUD.dismiss()
        
    }

    

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )

     }
    @IBAction func onChangeBtnTapped(_ sender: Any) {
        changePasswordView.isHidden = false

    }
    

    

}
