//
//  CategoriesVC.swift
//  D2020
//
//  Created by Macbook on 11/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

struct Category{
    var image: String
    var name: String
}
struct Subcategory{
    var image: String
    var name: String
    var rate: String
}

class CategoriesVC: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var SubCategoryTableView: UITableView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!

    //variables
    var list = ["جدة", "الرياض", "مكة","جدة", "الرياض", "مكة","جدة", "الرياض", "مكة"]
    var categoryArray = [categoriesDataClass]()
    var subcategoryArray = [SubCategoriesData]()
    var categoryId = 12
    var subcategoryId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        categoriesRequest()
        subCategoriesRequest()

    }
    func setup(){
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
        self.dropDown.isHidden = true
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        SubCategoryTableView.delegate = self
        SubCategoryTableView.dataSource = self

        
    }
  
    
                             // MARK:- Categories Request
    
    
    func categoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/categories"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Categories.self, from: result.data!) else{return}
                self?.categoryArray = apiResponseModel.data
                self?.categoryCollectionView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func subCategoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/sub_categories/\(categoryId)"
        print(categoryId)
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategories.self, from: result.data!) else{return}
                self?.subcategoryArray = apiResponseModel.data
                self?.SubCategoryTableView.reloadData()
                print("\(self!.subcategoryArray)")
                KRProgressHUD.dismiss()

            }
    }
    
    

    
    
}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.categoryImageView.sd_setImage(with: URL(string: categoryArray[indexPath.row].image))
        cell.nameLabel.text = categoryArray[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.categoryId = categoryArray[indexPath.row].id
        print("categoryId = " +  " \(categoryId)")
        subCategoriesRequest()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: 84)
    
    }
    // SubcategoryTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        let imageUrl = " \(APIConstant.BASE_IMAGE_URL.rawValue)\(subcategoryArray[indexPath.row].image)"
        cell.categoryImageView.sd_setImage(with: URL(string: imageUrl ))
        cell.nameLabel.text = subcategoryArray[indexPath.row].name
        cell.rateLabel.text = "12KM"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.subcategoryId = subcategoryArray[indexPath.row].id
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "SubcategoryStoresVC") as!  SubcategoryStoresVC
        scene.subcategoryId = self.subcategoryId
        navigationController?.pushViewController(scene, animated: true)
        
    }

    
    
    
}

