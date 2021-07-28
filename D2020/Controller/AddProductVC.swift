//
//  AddProductVC.swift
//  D2020
//
//  Created by Macbook on 27/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD


class AddProductVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var arabicNameTextField: UITextField!
    @IBOutlet weak var discTextField: UITextField!
    @IBOutlet weak var arabicDescTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var offerTextField: UITextField!
    @IBOutlet weak var choosePhotoTextField: UITextField!
    var storeId = 0
    var fileURL: URL?
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func addProduct(){
        KRProgressHUD.show()
        let name = "\(nameTextField.text ?? "")"
        let arabicName = arabicNameTextField.text
        let desc = discTextField.text
        let arabicDesc = arabicDescTextField.text
        let price = priceTextField.text
        let offer = offerTextField.text
        choosePhotoTextField.isUserInteractionEnabled = false
        let requestParameters = ["name": name ?? "","arabic_name": arabicName ?? "",
                                 "description": desc ?? "" , "arabic_description": arabicDesc ?? "",
                                 "price": price ?? "", "offer": offer ?? "" ]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/products/store/\(storeId)"
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
    
    @IBAction func onUploadBtnTapped(_ sender: Any) {
        chooseImage()
        
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
        addProduct()
    }
    

}
