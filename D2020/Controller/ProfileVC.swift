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
    var imagePicker = UIImagePickerController()
    var userToken: String = ""
    var iconClick = true
    var newUserImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileData()
        imagePicker.delegate = self
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
        let imageUrl = "\(apiResponseModel.data.photo ?? "")"
        self.userImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        self.addressTextBox.text = apiResponseModel.data.address ?? ""
        //        self.passwordTextField.text = apiResponseModel.data
        
        
        
        //        KRProgressHUD.dismiss()
        
    }
    func editUserProfile(){
        KRProgressHUD.show()
        let name = userNameTextField.text ?? ""
        let mobile = userPhoneTextField.text ?? ""
        let email = userMailTextField.text ?? ""
        let address = addressTextBox.text ?? ""
        let imgString = newUserImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        let requestParameters = ["name": name ?? "","mobile": mobile ?? "", "address": address ?? "", "email": email ?? "","image": imgString ?? ""]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/profile/update"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire.upload(multipartFormData: {[weak self] formData in
            formData.append(name.data(using: .utf8) ?? Data(), withName: "name")
            formData.append(mobile.data(using: .utf8) ?? Data(), withName: "mobile")
            formData.append(address.data(using: .utf8) ?? Data(), withName: "address")
            formData.append(email.data(using: .utf8) ?? Data(), withName: "email")
            if self?.newUserImage != nil{
                formData.append(self!.newUserImage!.jpegData(compressionQuality: 0.4)!, withName: "image")
            }

        }, to: apiURL,method: .post,headers: headers) { result in
            switch result{
            case .success(let request, _, _):
                if true{
                    request.responseData { data in
                        guard let responseData = data.data else{
                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                            return }
                        let jsonDecoder = JSONDecoder()
                        guard let reponseModel = try? jsonDecoder.decode(UpdateProfileResponse.self, from: responseData)else{
                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                            return
                        }
                        let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
                        let jsonConverter = JSONDecoder()
                        guard let profileLocalModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!)else{
                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                            return
                        }
                        print(responseData.prettyPrintedJSONString)
                        var profileLocal = profileLocalModel
                        profileLocal.data.photo = reponseModel.data?.photo ?? ""
                        profileLocal.data.mobile = reponseModel.data?.mobile ?? ""
                        profileLocal.data.mobile = reponseModel.data?.mobile ?? ""
                        profileLocal.data.name = reponseModel.data?.name ?? ""
                        profileLocal.data.email = reponseModel.data?.email ?? ""
                        let jsonEncoder = JSONEncoder()
                        guard let apiResponseModel = try? jsonEncoder.encode(profileLocal) else{
                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                            return
                        }
                        UserDefaults.standard.setValue(apiResponseModel, forKey: UserDefaultKey.USER_PROFILE.rawValue)
                        KRProgressHUD.showSuccess(withMessage: "تم حفظ التغيرات")

                    }

                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                }
            case .failure(_):
                KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
            }
        }
//        Alamofire
//            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: headers)
//            .response {[weak self] result in
//                print("Response Code : \(result.response?.statusCode)")
//                print("Response : \(result.data?.prettyPrintedJSONString)")
//
//
//                if result.response?.statusCode == 200{
//                    let jsonDecoder = JSONDecoder()
//                    guard let reponseModel = try? jsonDecoder.decode(UpdateProfileResponse.self, from: result.data ?? Data())else{
//                        KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
//                        return
//                    }
//                    let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
//                    let jsonConverter = JSONDecoder()
//                    guard let profileLocalModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!)else{
//                        KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
//                        return
//                    }
//                    var profileLocal = profileLocalModel
//                    profileLocal.data.photo = reponseModel.data?.photo ?? ""
//                    profileLocal.data.mobile = reponseModel.data?.mobile ?? ""
//                    profileLocal.data.mobile = reponseModel.data?.mobile ?? ""
//                    profileLocal.data.name = reponseModel.data?.name ?? ""
//                    profileLocal.data.email = reponseModel.data?.email ?? ""
//                    let jsonEncoder = JSONEncoder()
//                    guard let apiResponseModel = try? jsonEncoder.encode(profileLocal) else{
//                        KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
//                        return
//                    }
//                    UserDefaults.standard.setValue(result.data, forKey: UserDefaultKey.USER_PROFILE.rawValue)
//                    KRProgressHUD.showSuccess(withMessage: "تم حفظ التغيرات")
//
//                }else{
//                    KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
//                }
//
//            }
    }
    func profileGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(ProfileVC.userImageTapped(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGesture)
        
    }
    @objc func userImageTapped(recognizer: UITapGestureRecognizer){
        self.chooseImage()
    }
    
    func openCamera(){
        imagePicker.sourceType = .camera
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
        
    }
    @IBAction func onChangeBtnTapped(_ sender: Any) {
        changePasswordView.isHidden = false
        
    }
    
    @IBAction func onSaveButtonTap(_ sender: UIButton) {
        editUserProfile()
    }
    
    @IBAction func onChangeImageBtn(_ sender: Any) {
        self.chooseImage()
    }
    
    
    func chooseImage(){
        let imageSelectionAlert = UIAlertController(title: "اختار مصدر الصورة".localized(), message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "الكاميرا".localized(), style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "معرض الصور".localized(), style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "الغاء".localized(), style: .cancel)
        imageSelectionAlert.addAction(cameraAction)
        imageSelectionAlert.addAction(galleryAction)
        imageSelectionAlert.addAction(cancelAction)
        imageSelectionAlert.popoverPresentationController?.sourceView = self.view
        
        self.present(imageSelectionAlert, animated: true, completion: nil)
    }
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

extension ProfileVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.newUserImage = image
        self.userImage.image = image
//        var fileName = "image"
//        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
//            fileName = url.lastPathComponent
//        }else{
//            fileName = "\(UUID().uuidString).png"
//        }
//
//
//        let fileManager = FileManager.default
//        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        let imagePath = documentsPath?.appendingPathComponent("\(fileName)")
//
//        // extract image from the picker and save it
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//
//            let imageData = pickedImage.jpegData(compressionQuality: 0.2)
//            try! imageData?.write(to: imagePath!)
//            pickedImage.accessibilityIdentifier = "\(imagePath!)"
//            selectedImageSubject.onNext(pickedImage)
//        }else{
//            selectedImageSubject.onNext(image)
//        }
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
}
