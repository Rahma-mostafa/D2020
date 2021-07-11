//
//  AllSubCategoriesVC.swift
//  D2020
//
//  Created by Macbook on 13/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage


class SubcategoryStoresVC: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    //variables
    var list = ["جدة", "الرياض", "مكة","جدة", "الرياض", "مكة","جدة", "الرياض", "مكة"]
    var subcategoryId = 0
    var SubCategoryStoresArray = [SubCategoryStoresData]()
    var index = 3
    var filteredStore = "\(APIConstant.BASE_STORE_URL.rawValue)"
    var storeId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        subcategoriesStoresRequest()
        filterStores()
        print("orderIndex = \(index)")
       
    }
    func setup(){
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
        self.dropDown.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self

    }
    func filterStores(){
        if index == 0{
            descStoresRequest()
        }else if index == 1{
            ascStoresRequest()
        }else if index == 2{
            mostViewsStoresRequest()
        }else{
            subcategoriesStoresRequest()
        }
    }
    // MARK:- API Request
    func subcategoriesStoresRequest(){
        KRProgressHUD.show()
        print("subcategoryId = \(subcategoryId)")
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/category_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func descStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/desc_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func ascStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/asc_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func mostViewsStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/most_views_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    
    @IBAction func onFilterBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "OrderFilterVC") as!  OrderFilterVC
        scene.subcategoryId = self.subcategoryId
        navigationController?.pushViewController(scene, animated: true)
        
    }
    
    


}
extension SubcategoryStoresVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate ,UITableViewDelegate,UITableViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.textBox.text = self.list[row]
        self.dropDown.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.dropDown.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.textBox {
            self.dropDown.isHidden = true
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
 @IBAction func onDropButtonTapped(_ sender: Any) {
     if self.dropDown.isHidden == true{
         self.dropDown.isHidden = false
     }else{
         self.dropDown.isHidden = true
     }
 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubCategoryStoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        cell.categoryImageView.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(SubCategoryStoresArray[indexPath.row].image)"))
        cell.nameLabel.text = SubCategoryStoresArray[indexPath.row].name
//        cell.rateLabel.text = SubCategoryStoresArray[indexPath.row].rate
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.storeId = SubCategoryStoresArray[indexPath.row].id
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "SingleStoreDetailsVC") as!  SingleStoreDetailsVC
        scene.storeId = self.storeId
        navigationController?.pushViewController(scene, animated: true)
        
    }

}
