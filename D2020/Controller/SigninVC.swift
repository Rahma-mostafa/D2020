//
//  SigninVC.swift
//  D2020
//
//  Created by Macbook on 31/05/2021.
//

import UIKit

class SigninVC: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func onSigninButtonTapped(_ sender: Any) {
        // if no text entered
              if mailTextField.text!.isEmpty || passTextField.text!.isEmpty {
                  
                  // red placeholders
                mailTextField.attributedPlaceholder = NSAttributedString(string: "email".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                passTextField.attributedPlaceholder = NSAttributedString(string: "password".localized(), attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                  
              }else{
                
              }
    }
    
    @IBAction func withoutSigningButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        navigationController?.pushViewController(scene, animated: true)
    }
    
    
}
