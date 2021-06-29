//
//  CategoriesVC.swift
//  D2020
//
//  Created by Macbook on 11/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!

    //variables
    var list = ["جدة", "الرياض", "مكة","جدة", "الرياض", "مكة","جدة", "الرياض", "مكة"]
    var categoryArray = [Category(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه"),Category(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه"),Category(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه"),Category(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه")]
    var subcategoryArray = [Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M"),Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M"),Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M"),Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
        self.dropDown.isHidden = true
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        tableView.delegate = self
        tableView.dataSource = self

        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        cell.categoryImageView.image = UIImage(named: subcategoryArray[indexPath.row].image)
        cell.nameLabel.text = subcategoryArray[indexPath.row].name
        cell.rateLabel.text = subcategoryArray[indexPath.row].rate
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "AllSubCategoriesVC")
        navigationController?.pushViewController(scene, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.categoryImageView.image = UIImage(named: categoryArray[indexPath.row].image)
        cell.nameLabel.text = categoryArray[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: 84)
    
    }
    
    
}

