//
//  SectionsVC.swift
//  D2020
//
//  Created by Macbook on 10/06/2021.
//

import UIKit
struct Sections{
    var image: String
    var type: String
    var evaluation: String
}

class SectionsVC: UIViewController {

    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    // variables
    var list = ["جدة", "الرياض", "مكة","جدة", "الرياض", "مكة","جدة", "الرياض", "مكة"]
    var sectionArray = [Sections(image: "food@-1",type: "مطاعم ،كافيهات",evaluation: "اكتر من ٩٠ مطعم وكافيه"),Sections(image: "food@-1",type: "مطاعم ،كافيهات",evaluation: "اكتر من ٩٠ مطعم وكافيه"),Sections(image: "food@-1",type: "مطاعم ،كافيهات",evaluation: "اكتر من ٩٠ مطعم وكافيه"),Sections(image: "food@-1",type: "مطاعم ،كافيهات",evaluation: "اكتر من ٩٠ مطعم وكافيه"),Sections(image: "food@-1",type: "مطاعم ،كافيهات",evaluation: "اكتر من ٩٠ مطعم وكافيه")]
    override func viewDidLoad() {
            super.viewDidLoad()
        setup()
             
    }
    func setup(){
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
        self.dropDown.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self

    }


    
}
extension SectionsVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
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
    @IBAction func onDropDownBtn(_ sender: Any) {
        if self.dropDown.isHidden == true{
            self.dropDown.isHidden = false
        }else{
            self.dropDown.isHidden = true
        }

    }
}
extension SectionsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SectionsCell", owner: self, options: nil)?.first as! SectionsCell
        cell.sectionImageView.image = UIImage(named: sectionArray[indexPath.row].image)
        cell.typeLabel.text = sectionArray[indexPath.row].type
        cell.evaluationLabel.text = sectionArray[indexPath.row].evaluation
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "CategoriesVC")
        navigationController?.pushViewController(scene, animated: true)
    }
    
    
}
