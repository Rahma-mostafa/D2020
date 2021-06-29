//
//  ProfileVC.swift
//  D2020
//
//  Created by Macbook on 23/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class ProfileVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    @IBOutlet weak var userMailTextField: UITextField!
    @IBOutlet weak var userBirthDayTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfimationTextField: UITextField!
    @IBOutlet weak var userCityLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNickNameLabel: UILabel!
    @IBOutlet weak var cityTextBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    var userToken: String = ""
    var citiesArray = [CitiesDataClass]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileRequest()
        setup()
        citiesRequest()


    }
    func setup(){
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
        self.dropDown.isHidden = true
    }
    func userProfileRequest(){
        KRProgressHUD.show()
        let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
        let jsonConverter = JSONDecoder()
        guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!) else{
            print ("nil")
            return
        }
        print(apiResponseModel.data)
        self.userNameLabel.text = apiResponseModel.data.name ?? ""
        self.userNameTextField.text = apiResponseModel.data.name ?? ""
//        self.userNickNameLabel.text = "\(apiResponseModel.status)"
        self.userPhoneTextField.text = apiResponseModel.data.mobile ?? ""
        self.userMailTextField.text = apiResponseModel.data.email ?? ""
        self.userBirthDayTextField.text = apiResponseModel.data.birthDate ?? "This field is empty"
        
        
        
        KRProgressHUD.dismiss()

        
    }
    func citiesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/cities"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Cities.self, from: result.data!) else{return}
                self?.citiesArray = apiResponseModel.data
                DispatchQueue.main.async {
                    self?.dropDown.reloadComponent(0)
                }
                print("\(self!.citiesArray)")
                KRProgressHUD.dismiss()

            }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 500)

     }
    
    
    @IBAction func onChooseBtnTapped(_ sender: Any) {
        if self.dropDown.isHidden == true{
            self.dropDown.isHidden = false
        }else{
            self.dropDown.isHidden = true
        }
    }
    
    

}
extension ProfileVC:  UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
//        return "\(citiesArray[row].name)"
        return ("cnbcn")
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

//        self.cityTextBox.text = "\(citiesArray[row].name)"
        self.cityTextBox.text = "cbbchvc"

        self.dropDown.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.cityTextBox {
            self.dropDown.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.cityTextBox {
            self.dropDown.isHidden = true
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    
}
