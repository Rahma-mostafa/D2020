//
//  RegistrationVC.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class AddStoreVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var arabicNameTextField: UITextField!
    @IBOutlet weak var chooseLocationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var discTextField: UITextField!
    @IBOutlet weak var arabicDescTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var categoryTextFiled: UITextField!
    @IBOutlet weak var subcategoryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var choosePhotoTextField: UITextField!
    @IBOutlet weak var chooseVideoTextField: UITextField!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var contantView: UIView!
    var categoryArray = [CategoryDataClass]()
    var subcategoryArray = [SubcategoryStoreClass]()
    var citiesArray = [CityData]()
    var iconClick = true
    var index = 0
    var categoryId = 0
    var subcategoryId = 0
    var cityId = 0
    var imagePicker = UIImagePickerController()
    var newStoreImage: UIImage?
    var fileURL: URL?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
        
    }
    func setup(){
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        contantView.isHidden = true
        imagePicker.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 700 )
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
    
    func editUserProfile(){
        //        KRProgressHUD.show()
        //        let name = userNameTextField.text ?? ""
        //        let mobile = userPhoneTextField.text ?? ""
        //        let email = userMailTextField.text ?? ""
        //        let address = addressTextBox.text ?? ""
        //        let imgString = newUserImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        //        let requestParameters = ["name": name ?? "","mobile": mobile ?? "", "address": address ?? "", "email": email ?? "","image": imgString ?? ""]
        //        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        //        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        //        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/profile/update"
        //        guard let apiURL = URL(string: apiURLInString) else{ return }
        //        Alamofire.upload(multipartFormData: {[weak self] formData in
        //            formData.append(name.data(using: .utf8) ?? Data(), withName: "name")
        //            formData.append(mobile.data(using: .utf8) ?? Data(), withName: "mobile")
        //            formData.append(address.data(using: .utf8) ?? Data(), withName: "address")
        //            formData.append(email.data(using: .utf8) ?? Data(), withName: "email")
        //
        //            if self?.fileURL != nil{
        //
        //                formData.append((self?.fileURL!)!, withName: "image")
        //            }
        //
        //        }, to: apiURL,method: .post,headers: headers) { result in
        //            switch result{
        //            case .success(let request, _, _):
        //                print(request.debugDescription)
        //                print(request.request?.debugDescription)
        //                if true{
        //                    request.responseData { data in
        //                        guard let responseData = data.data else{
        //                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
        //                            return }
        //                        let jsonDecoder = JSONDecoder()
        //                        guard let reponseModel = try? jsonDecoder.decode(UpdateProfileResponse.self, from: responseData)else{
        //                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
        //                            return
        //                        }
        //                        let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
        //                        let jsonConverter = JSONDecoder()
        //                        guard let profileLocalModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!)else{
        //                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
        //                            return
        //                        }
        //                        print(responseData.prettyPrintedJSONString)
        //                        var profileLocal = profileLocalModel
        //                        profileLocal.data.photo = reponseModel.data?.photo ?? ""
        //                        profileLocal.data.mobile = reponseModel.data?.mobile ?? ""
        //                        profileLocal.data.mobile = reponseModel.data?.mobile ?? ""
        //                        profileLocal.data.name = reponseModel.data?.name ?? ""
        //                        profileLocal.data.email = reponseModel.data?.email ?? ""
        //                        let jsonEncoder = JSONEncoder()
        //                        guard let apiResponseModel = try? jsonEncoder.encode(profileLocal) else{
        //                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
        //                            return
        //                        }
        //                        UserDefaults.standard.setValue(apiResponseModel, forKey: UserDefaultKey.USER_PROFILE.rawValue)
        //                        KRProgressHUD.showSuccess(withMessage: "تم حفظ التغيرات")
        //
        //                    }
        //
        //                }else{
        //                    KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
        //                }
        //            case .failure(_):
        //                KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
        //            }
        //        }
    }
    
    // API request
    func registerNewStore(){
        KRProgressHUD.show()
        let name = "\(nameTextField.text ?? "")"
        let arabicName = arabicNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let mail = mailTextField.text ?? ""
        let address = addressTextField.text ?? ""
        let desc = discTextField.text ?? ""
        let arabicDesc = arabicDescTextField.text ?? ""
        self.categoryTextFiled.isUserInteractionEnabled = false
        let code = codeTextField.text ?? ""
        let date = dateTextField.text ?? ""
        //        let imgString = newStoreImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        let longi = ""
        let lati = ""
        let video = ""
        
        let requestParameters = ["name": name ,"phone": phone,
                                 "address": address,"email": mail,"code": code,"arabic_name": arabicName,
                                 "description": desc , "arabic_description": arabicDesc,
                                 "city_id" : "\(cityId)" , "category_id": "\(categoryId)",
                                 "sub_category_id": "\(subcategoryId)", "longi": longi , "lati": lati,
                                 "end": date , "video": video
        ]
        
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores/store"
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire.upload(multipartFormData: {[weak self] formData in
            for (key,value) in requestParameters{
                formData.append(value.data(using: .utf8) ?? Data(), withName: key)
            }
            if self?.fileURL != nil{
                
                formData.append((self?.fileURL!)!, withName: "image")
            }
            
        }, to: apiURL,method: .post,headers: headers) { result in
            switch result{
            case .success(let request, _, _):
                print(request.debugDescription)
                print(request.request?.debugDescription)
                if true{
                    request.responseData { data in
                        print("Response : \(data.debugDescription)")
                        if data.response?.statusCode == 200{
                            KRProgressHUD.showSuccess(withMessage: "تم الحفظ بنجاح")
                        }else{
                            KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                        }
                        
                    }
                    
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                }
            case .failure(_):
                KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
            }
        }
        
        
        
    }
    func categoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/categories"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(CategoriesForOwner.self, from: result.data!) else{return}
                self?.categoryArray = apiResponseModel.data
                self?.categoryTableView.reloadData()
                KRProgressHUD.dismiss()
                
            }
    }
    func subcategoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/sub_categories/12"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(SubcategoryForOwner.self, from: result.data!) else{return}
                self?.subcategoryArray = apiResponseModel.data
                self?.categoryTableView.reloadData()
                KRProgressHUD.dismiss()
                
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
                self?.citiesArray = apiResponseModel.data
                self?.categoryTableView.reloadData()
                KRProgressHUD.dismiss()
                
            }
    }
    
    
    
    @IBAction func onCategoryBtnTapped(_ sender: Any) {
        index = 1
        if(iconClick == true) {
            contantView.isHidden = false
            categoriesRequest()
            
        } else {
            contantView.isHidden = true
        }
        
        iconClick = !iconClick
        
    }
    @IBAction func onSubcategoryBtnTapped(_ sender: Any) {
        index = 2
        if(iconClick == true) {
            contantView.isHidden = false
            subcategoriesRequest()
            
        } else {
            contantView.isHidden = true
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func onCityBtnTapped(_ sender: Any) {
        index = 3
        if(iconClick == true) {
            contantView.isHidden = false
            citiesRequest()
        } else {
            contantView.isHidden = true
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func onChoosePhotoTextField(_ sender: Any) {
        chooseImage()
    }
    @IBAction func onChooseVideoBtnTapped(_ sender: Any) {
        chooseImage()
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
        registerNewStore()
    }
}
extension AddStoreVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 1{
            return categoryArray.count
        }else if index == 2 {
            return subcategoryArray.count
        }else{
            return citiesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryForOwnerCell", for: indexPath) as! CategoryForOwnerCell
        if index == 1{
            cell.categoryLabel.text = categoryArray[indexPath.row].arabicName
        }else if index == 2 {
            cell.categoryLabel.text = subcategoryArray[indexPath.row].arabicName
        }else{
            cell.categoryLabel.text = citiesArray[indexPath.row].name
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if index == 1{
            self.categoryTextFiled.text = categoryArray[indexPath.row].arabicName
            self.categoryId = categoryArray[indexPath.row].id
        }else if index == 2 {
            self.subcategoryTextField.text = subcategoryArray[indexPath.row].arabicName
            self.subcategoryId = subcategoryArray[indexPath.row].id
            
        }else{
            self.cityTextField.text = citiesArray[indexPath.row].name
            self.cityId = citiesArray[indexPath.row].id
        }
        self.contantView.isHidden = true
        
        
    }
}



extension AddStoreVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.newStoreImage = image
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        
        // extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let imageData = pickedImage.jpegData(compressionQuality: 0.4)
            try! imageData?.write(to: imagePath!)
            self.fileURL = imagePath
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
}
