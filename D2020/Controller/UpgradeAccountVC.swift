//
//  UpgradeAccountVC.swift
//  D2020
//
//  Created by Macbook on 08/06/2021.
//

import UIKit

class UpgradeAccountVC: UIViewController {

    @IBOutlet weak var delegateBackView: UIView!
    
    @IBOutlet weak var delegateLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var salesBackView: UIView!
    @IBOutlet weak var salesLabel: UILabel!
    @IBOutlet weak var ckeck2imageView: UIImageView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func onDelegateBtnTapped(_ sender: Any) {
        if self.delegateBackView.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) && self.delegateLabel.textColor == .black {
            self.delegateBackView.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6235294118, blue: 0, alpha: 1)
            self.delegateLabel.textColor = .white
            self.salesBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.salesLabel.textColor = .black
            
        }else{
            self.delegateBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.delegateLabel.textColor = .black
        }
        
    }
    
    @IBAction func onSalesbuttontapped(_ sender: Any) {
        if self.salesBackView.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) && self.salesLabel.textColor == .black {
            self.salesBackView.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6235294118, blue: 0, alpha: 1)
            self.salesLabel.textColor = .white
            self.delegateBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.delegateLabel.textColor = .black
        }else{
            self.salesBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.salesLabel.textColor = .black
        }
        
    }
    @IBAction func onConfirmBtnTapped(_ sender: Any) {
        self.confirmBtn.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6235294118, blue: 0, alpha: 1)
    }
}
