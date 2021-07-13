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

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
    @IBOutlet weak var saveBtn: UIButton!
    var citiesArray = [CitiesDataClass]()
    var picker = UIImagePickerController()
    var userToken: String = ""
    var iconClick = true

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileData()
        changePasswordView.isHidden = true
    }
    


    func userProfileData(){
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
        let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(apiResponseModel.data.photo ?? "")"
        self.userImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        self.addressTextBox.text = apiResponseModel.data.address ?? ""
//        self.passwordTextField.text = apiResponseModel.data
        
        
        
//        KRProgressHUD.dismiss()
        
    }
    func editUserProfile(){
        KRProgressHUD.show()
        let name = userNameTextField.text
        let mobile = userPhoneTextField.text
        let email = userMailTextField.text
        let address = addressTextBox.text
        let imgString = userImage.image?.pngData()?.base64EncodedString()

        let requestParameters = ["name": name ?? "","mobile": mobile ?? "", "address": address ?? "", "email": email ?? "","image": imgString ?? ""]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/profile/update"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم حفظ التغيرات")
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                }
                
            }
    }
    func profileGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(ProfileVC.userImageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGesture)
        
    }
    @objc func userImageTapped(recognizer: UITapGestureRecognizer){
        uploadUserImage()
    }
    func uploadUserImage(){
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
                {
                    UIAlertAction in
                    self.openCamera()
            }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
                {
                    UIAlertAction in
                    self.openGallary()
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                {
                    UIAlertAction in
            }

            // Add the actions
            picker.delegate = self
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
        func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                picker.sourceType = UIImagePickerController.SourceType.camera
                self .present(picker, animated: true, completion: nil)
            }else{
                let alert = UIAlertView()
                alert.title = "Warning"
                alert.message = "You don't have camera"
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
        func openGallary(){
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        //MARK:UIImagePickerControllerDelegate
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
            picker .dismiss(animated: true, completion: nil)
            userImage.image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            print("picker cancel.")
        }
    
        
    
  

    

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )

     }
    @IBAction func onChangeBtnTapped(_ sender: Any) {
        changePasswordView.isHidden = false

    }
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        print("save")
        editUserProfile()

    }
    
    @IBAction func onChangeImageBtn(_ sender: Any) {
       
    }
}
