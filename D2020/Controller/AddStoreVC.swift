//
//  RegistrationVC.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

class AddStoreVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var arabicNameTextField: UITextField!
    @IBOutlet weak var chooseLocationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var discTextField: UITextField!
    @IBOutlet weak var arabicDescTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var categoryTextFiled: UITextField!
    @IBOutlet weak var emtyTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var choosePhotoTextField: UITextField!
    @IBOutlet weak var chooseVideoTextField: UITextField!
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var contantView: UIView!
    var categoryArray = [CategoryDataClass]()
    var iconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

       
    }
    func setup(){
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        contantView.isHidden = true  
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 700 )
    }
    func registerNewStore(){
        KRProgressHUD.show()
        let name = nameTextField.text
        let arabicName = arabicNameTextField.text
        let phone = phoneTextField.text
        let mail = mailTextField.text
        let address = addressTextField.text
        let city = cityTextField.text
        let desc = discTextField.text
        let arabicDesc = arabicDescTextField.text
        let category = categoryTextFiled.text
        self.categoryTextFiled.isUserInteractionEnabled = false
        let code = codeTextField.text
        let date = dateTextField.text
        let image = ""
        let category_id = ""
        let sub_category_id = ""
        let longi = ""
        let lati = ""
        let end = ""
        let video = ""

        let requestParameters = ["name": name,"phone": phone,
        "address": address,"email": mail,"code": code,"arabic_name": arabicName,
        "description": desc , "arabic_description": arabicDesc!, "image": image,
        "city_id" : city , "category_id": category_id,
        "sub_category_id": sub_category_id, "longi": longi , "lati": lati,
        "end": end , "video": video
    ]
//        let requestParameters = ["name": name ?? "","phone": phone ?? "",
//        "address": address ?? "","email": mail ?? "","code": code ?? "","arabic_name": arabicName ?? "",
//        "description": desc ?? "" , "arabic_description": arabicDesc ?? "", "image": image ?? "",
//        "city_id" : city ?? "" , "category_id": category_id ?? "",
//        "sub_category_id": sub_category_id ?? "", "longi": longi ?? "" , "lati": lati ?? "",
//        "end": end ?? "", "video": video ?? ""
//    ]
       let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores/store"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage:"تم تسجيل المحل")
                }else if result.error != nil{
                    KRProgressHUD.showError(withMessage: "عطل بالانترنت")
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم التسجيل ")
                }
                
            }
    }
    // API request
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


    
    @IBAction func onCategoryBtnTapped(_ sender: Any) {
        if(iconClick == true) {
            contantView.isHidden = false
            categoriesRequest()
            
              } else {
                contantView.isHidden = true
              }

              iconClick = !iconClick
        
    }
    
    @IBAction func onCityBtnTapped(_ sender: Any) {
    }
    
    @IBAction func onChoosePhotoTextField(_ sender: Any) {
    }
    @IBAction func onChooseVideoBtnTapped(_ sender: Any) {
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
            registerNewStore()
    }
}
extension AddStoreVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryForOwnerCell", for: indexPath) as! CategoryForOwnerCell
        cell.categoryLabel.text = categoryArray[indexPath.row].name
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoryTextFiled.text = categoryArray[indexPath.row].name
    }
    
}
