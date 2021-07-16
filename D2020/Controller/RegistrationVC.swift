//
//  RegistrationVC.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit

class RegistrationVC: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 500 )
        
    }
    
    @IBAction func onCategoryBtnTapped(_ sender: Any) {
    }
    
    @IBAction func onCityBtnTapped(_ sender: Any) {
    }
    
    @IBAction func onChoosePhotoTextField(_ sender: Any) {
    }
    @IBAction func onChooseVideoBtnTapped(_ sender: Any) {
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
    }
}
