//
//  AllSubCategoriesVC.swift
//  D2020
//
//  Created by Macbook on 13/06/2021.
//

import UIKit

class AllSubCategoriesVC: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    //variables
    var list = ["جدة", "الرياض", "مكة","جدة", "الرياض", "مكة","جدة", "الرياض", "مكة"]
    var subcategoryArray = [Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M"),Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M"),Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M"),Subcategory(image: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x", name: "كافيه", rate: "12K.M")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
        self.dropDown.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self

    }
    


}
extension AllSubCategoriesVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate ,UITableViewDelegate,UITableViewDataSource{
    
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

}
