//
//  SigninVC.swift
//  D2020
//
//  Created by Macbook on 31/05/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class SigninVC: BaseController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var delegateBtton: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var ownerBtn: UIButton!
    @IBOutlet weak var showBtn: UIButton!
    // variables
    var iconClick = true

    var apiURLInString = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true

        
    }
    @IBAction func onUserBttonTapped(_ sender: Any) {
        self.userBtn.backgroundColor = .orange
        self.delegateBtton.backgroundColor = #colorLiteral(red: 0.4195685685, green: 0.4196329117, blue: 0.4195545018, alpha: 1)
        self.ownerBtn.backgroundColor = #colorLiteral(red: 0.4195685685, green: 0.4196329117, blue: 0.4195545018, alpha: 1)
        UserDefaults.standard.setValue("user", forKey: UserTypeKeys.OWNER.rawValue)
    }
    
    @IBAction func onOwnerBtnTapped(_ sender: Any) {
        self.userBtn.backgroundColor = #colorLiteral(red: 0.4195685685, green: 0.4196329117, blue: 0.4195545018, alpha: 1)
        self.delegateBtton.backgroundColor = #colorLiteral(red: 0.4195685685, green: 0.4196329117, blue: 0.4195545018, alpha: 1)
        self.ownerBtn.backgroundColor = .orange
        UserDefaults.standard.setValue("owner", forKey: UserTypeKeys.OWNER.rawValue)
    }
    
    @IBAction func onDelegateBtnTapped(_ sender: Any) {
        self.userBtn.backgroundColor = #colorLiteral(red: 0.4195685685, green: 0.4196329117, blue: 0.4195545018, alpha: 1)
        self.delegateBtton.backgroundColor = .orange
        self.ownerBtn.backgroundColor = #colorLiteral(red: 0.4195685685, green: 0.4196329117, blue: 0.4195545018, alpha: 1)
        UserDefaults.standard.setValue("rep", forKey: UserTypeKeys.OWNER.rawValue)
    }
    
    @IBAction func onSigninButtonTapped(_ sender: Any) {
        // if no text entered
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        let scene = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
////                            scene.type = self!.type!
//        self.navigationController?.pushViewController(scene, animated: true)

        if mailTextField.text!.isEmpty || passTextField.text!.isEmpty {

            // red placeholders
            mailTextField.attributedPlaceholder = NSAttributedString(string: "email".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            passTextField.attributedPlaceholder = NSAttributedString(string: "password".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
        }else{

            //Show Loading Indicator
            KRProgressHUD.show()
            //Construct Request Params which are data the API need to work
            let requestParameters = ["mobile": mailTextField.text ?? "","password": passTextField.text ?? ""]
            /*Constructing API URL should be done in two step:
             1-Construct API URL as string variable
             2-Pass API URL String to URL object to finish API URL Building
             BASE URL is a common part in all API calls.
             we create it once as a constant instead of typing it many times in each API URL.
             */
            //Construct API URL In string variable
            guard let userType = UserDefaults.standard.string(forKey: UserTypeKeys.OWNER.rawValue) else { return }
            if userType == "user"{
                apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/login"
            }else if userType == "owner"{
                apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/login"

            }else if userType == "delegate"{
                apiURLInString = "\(APIConstant.BASE_URL.rawValue)rep/login"
            }else{
                KRProgressHUD.showError(withMessage: "من فضلك حدد اذا كنت مستخدم عادي او صاحب محل او مندوب")
            }
            //Convert API URL from string to URL object because Alamofire deals only with URL object not string variables
            guard let apiURL = URL(string: apiURLInString) else{ return }
            //Call API with alamofire
            Alamofire
                .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: nil)
                .response {[weak self] result in
                    //API Response

                    //Check if there is any errors in connecting to API, if there it's an internet connection error, we do this by checking if error is not nill, if error is not nill there is an error.
                    if result.error != nil{
                        //We just show an error alert with a message.
                        KRProgressHUD.showError(withMessage: "عطل بالانترنت")

                    }else{
                        //Here API Request is successfull, and we recieved a response.

                        /*
                         We check on status code , as it tells us if the required operation is successfull or not
                         for example in login API
                         200 means that user has logged in succesfully, any thing else tells us that user didn't logged in successfully due to many reasons such as wrong password or mobile.
                         */
                        //Checking if status code is 200 which means user has logged in successfully.
                        if result.response?.statusCode == 200{
                            /*
                             If user has logged in, we need to do some things,
                             1-Convert Reponse from json to model.(we always do this with any API response, the next steps differ in each API response, but this step always we do.)
                             2- Save user token because we will use it in some API calls, by sending it as the authorization field in header.
                             3-Save user profile to show any data related to user such as name,mobile,.....
                             4-Hide loading indicator

                             5-Navigate to home.
                             */
                            //We start by making an object from the class that convert API response from json to model in swift.
                            let jsonConverter = JSONDecoder()
                            //call the method decode which have the ability to transform json to model, this can be done by passing the json (result.data) to method and the model we want to fill it with the data, we use guard to check if model is not null, if model is null that means that convert failed .
                            guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: result.data!) else{

                                return
                            }
                            //Saving the user token in user defaults.
                            UserDefaults.standard.setValue(apiResponseModel.data.token ?? "", forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue)
                            //Saving user profile in user defaults database to retrieve it in application without doing api call.
                            UserDefaults.standard.setValue(result.data, forKey: UserDefaultKey.USER_PROFILE.rawValue)
                            print("\(apiResponseModel.data.token)")
                            //Hide loading indicator
                            KRProgressHUD.dismiss()
                            //Navigating to home
                            let storyboard = UIStoryboard(name: "Home", bundle: nil)
                            let scene = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//                            scene.type = self!.type!
                            self?.navigationController?.pushViewController(scene, animated: true)

                        }else{
                            KRProgressHUD.showError(withMessage: "بيانات الدخول غير صحيحة")
                        }
                    }
                }

        }
    }
    
    @IBAction func withoutSigningButtonTapped(_ sender: Any) {
        navToHomeWithoutSigning()
    }
    @IBAction func onShowBtnTapped(_ sender: Any) {
        if(iconClick == true) {
            passTextField.isSecureTextEntry = false
            showBtn.tintColor = .black
              } else {
            passTextField.isSecureTextEntry = true
              }

              iconClick = !iconClick
    }
    

    @IBAction func onNewAccountBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
        navigationController?.pushViewController(scene, animated: true)
    }
    func navToHomeWithoutSigning(){
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        navigationController?.pushViewController(scene, animated: true)
    }
    
}
