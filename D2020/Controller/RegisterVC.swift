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
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var cityTableView: UITableView!
    var iconClick = true
    var type = ""
    var apiURLInString = ""
    var citiesArray = [CityData]()
    var cityId = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        cityView.isHidden = true
        cityTableView.delegate = self
        cityTableView.dataSource = self

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
        
        let requestParameters = ["name": name ?? "","mobile": phone ?? "","address": address ?? "","email": mail ?? "","password": password ?? "", "city_id": cityId ?? ""]
        if self.type == "user"{
             apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/register"
        }else if self.type == "owner"{
            apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/register"
        }else if self.type == "delegate"{
            apiURLInString = "\(APIConstant.BASE_URL.rawValue)rep/register"
        }
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم التسجيل")
                    self?.navToSignIn()
                }else if result.response?.statusCode == 400 {
                    KRProgressHUD.showError(withMessage: "قيمة الجوال تم استخدامها مسبقاً")
                    self?.phoneTextField.attributedPlaceholder = NSAttributedString(string: "enter your mobile".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                    
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم تسجيل الدخول")
                }
                
            }
    }
    func citiesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/cities"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(StoresCities.self, from: result.data!) else{return}
                self?.citiesArray = apiResponseModel.data ?? [CityData]()
                self?.cityTableView.reloadData()
                KRProgressHUD.dismiss()
                
            }
    }
    @IBAction func onCityBtnTapped(_ sender: Any) {
        if(iconClick == true) {
            cityView.isHidden = false
            citiesRequest()
        } else {
            cityView.isHidden = true
        }
        
        iconClick = !iconClick
    }
    @IBAction func onShowPassBtn(_ sender: Any) {
        if(iconClick == true) {
            passwordTextField.isSecureTextEntry = false
              } else {
                passwordTextField.isSecureTextEntry = true
              }

              iconClick = !iconClick
    }
    func navToSignIn(){
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as! SigninVC
//        scene.type = self.type
        navigationController?.pushViewController(scene, animated: true)
        
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
extension RegisterVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryForOwnerCell", for: indexPath) as! CategoryForOwnerCell
        cell.categoryLabel.text = citiesArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        self.cityTextField.text = citiesArray[indexPath.row].name
        self.cityId = String(citiesArray[indexPath.row].id ?? 0)
        self.cityView.isHidden = true
    }
        
        
    


    
    
}
