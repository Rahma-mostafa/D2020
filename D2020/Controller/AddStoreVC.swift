//
//  RegistrationVC.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import CoreLocation


class AddStoreVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var arabicNameTextField: UITextField!
    @IBOutlet weak var discTextField: UITextField!
    @IBOutlet weak var arabicDescTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var categoryTextFiled: UITextField!
    @IBOutlet weak var subcategoryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var choosePhotoTextField: UITextField!
    @IBOutlet weak var chooseVideoTextField: UITextField!
    @IBOutlet weak var chooseLocationTextField: UITextField!
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
    var action = ""
    var storeId = 0
    var storeLocation: CLLocationCoordinate2D?
    var isSelected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if isSelected == true {
            chooseLocationTextField.text = "location_selected".localized()
        }
        chooseDate()
        
        
        
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
    func chooseDate(){
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

    }
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
        donedatePicker()
    }
    func donedatePicker(){
      //For date formate
       let formatter = DateFormatter()
       formatter.dateFormat = "dd-MM-yyyy"
       dateTextField.text = formatter.string(from: datePicker.date)
       //dismiss date picker dialog
       self.view.endEditing(true)
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
        let date = dateTextField.text ?? ""
        var longi = ""
        if let long = storeLocation?.longitude{
            longi = "\(long)"
        }
        var lati = ""
        if let lat = storeLocation?.latitude{
            lati = "\(lat)"
        }
        let video = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateFormatted = dateFormatter.string(from: Date())
        let requestParameters = ["name": name ,"phone": phone,
                                 "address": address,"email": mail,"arabic_name": arabicName,
                                 "description": desc , "arabic_description": arabicDesc,
                                 "city_id" : "\(cityId)" , "category_id": "\(categoryId)",
                                 "sub_category_id": "\(subcategoryId)", "longi": longi , "lati": lati,
                                 "end": dateFormatted , "video": video]

        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores/store"
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire.upload(multipartFormData: {[weak self] formData in
            for (key,value) in requestParameters{
                formData.append(value.data(using: .utf8) ?? Data(), withName: key)
            }
            if self?.fileURL != nil{
                if let image = Helper.load(fileURL: self!.fileURL!) {
                    if let pngImage = image.pngData(){
                        let fileName = "storeي.png"
                        var documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let newFileURL = documentsUrl.appendingPathComponent(fileName)
                        try? pngImage.write(to: newFileURL, options: .atomic)
                        formData.append(newFileURL, withName: "image")
                    }
                }
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
                            print(data.response?.statusCode)
                        }
                    }
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم الحفظ")
                }
            case .failure(let error):
                print("Error : \(error)")
                KRProgressHUD.showError(withMessage: "فشل العملية")
            }
        }
    
        
    }
    func editStore(){
        KRProgressHUD.show()
        let name = "\(nameTextField.text ?? "")"
        let arabicName = arabicNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let mail = mailTextField.text ?? ""
        let address = addressTextField.text ?? ""
        let desc = discTextField.text ?? ""
        let arabicDesc = arabicDescTextField.text ?? ""
        self.categoryTextFiled.isUserInteractionEnabled = false
        let date = dateTextField.text ?? ""
        var longi = ""
        if let long = storeLocation?.longitude{
            longi = "\(long)"
        }
        var lati = ""
        if let lat = storeLocation?.latitude{
            lati = "\(lat)"
        }
        let video = ""
        
        let requestParameters = ["name": name ,"phone": phone,
                                 "address": address,"email": mail,"arabic_name": arabicName,
                                 "description": desc , "arabic_description": arabicDesc,
                                 "city_id" : "\(cityId)" , "category_id": "\(categoryId)",
                                 "sub_category_id": "\(subcategoryId)", "longi": longi , "lati": lati,
                                 "end": date , "video": video
        ]
        
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores/update/\(storeId)"
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
                            KRProgressHUD.showSuccess(withMessage: "تم التعديل بنجاح")
                        }else{
                            KRProgressHUD.showError(withMessage: "لم يتم التعديل")
                        }
                    }
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم التعديل")
                }
            case .failure(_):
                KRProgressHUD.showError(withMessage: "فشل العملية")
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
                do{
                    try jsonConverter.decode(CategoriesForOwner.self, from: result.data!)
                }catch let error{
                    print("\(error)")
                }
                guard let apiResponseModel = try? jsonConverter.decode(CategoriesForOwner.self, from: result.data!) else{return}
                self?.categoryArray = apiResponseModel.data ?? [CategoryDataClass]()
                self?.categoryTableView.reloadData()
                KRProgressHUD.dismiss()
                
            }
    }
    func subcategoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/sub_categories/\(categoryId)"
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
                do{
                    try jsonConverter.decode(StoresCities.self, from: result.data!)
                }catch let error{
                    print("\(error)")
                }
                guard let apiResponseModel = try? jsonConverter.decode(StoresCities.self, from: result.data!) else{return}
                self?.citiesArray = apiResponseModel.data ?? [CityData]()
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
    @IBAction func onChooseLocationBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Owner", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "StoreLocationVC") as! StoreLocationVC
        scene.onLocationSelected = {[weak self] location in self?.storeLocation = location}
        navigationController?.pushViewController(scene, animated: true)
    }
    
    @IBAction func onChoosePhotoTextField(_ sender: Any) {
        chooseImage()
    }
    @IBAction func onChooseVideoBtnTapped(_ sender: Any) {
        chooseImage()
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
        if action == "editStore"{
            editStore()
        }else{
            registerNewStore()
        }
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
            self.categoryId = categoryArray[indexPath.row].id ?? 0
        }else if index == 2 {
            self.subcategoryTextField.text = subcategoryArray[indexPath.row].arabicName
            self.subcategoryId = subcategoryArray[indexPath.row].id
            
        }else{
            self.cityTextField.text = citiesArray[indexPath.row].name
            self.cityId = citiesArray[indexPath.row].id ?? 0
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
            self.choosePhotoTextField.text = "photo_Selected".localized()
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
}
