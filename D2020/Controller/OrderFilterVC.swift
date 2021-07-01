//
//  OrderFilterVC.swift
//  D2020
//
//  Created by Macbook on 01/07/2021.
//

import UIKit

class OrderFilterVC: BaseController {
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    @IBOutlet weak var mostVisitBtn: UIButton!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true

    }
    func setNav(){
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SubcategoryStoresVC") as! SubcategoryStoresVC
        scene.index = self.index
        navigationController?.pushViewController(scene, animated: true)

        
    }
    @IBAction func onOlderBtnTapped(_ sender: Any) {
        self.index = 0
        orderBtn.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        newBtn.backgroundColor = .white
        mostVisitBtn.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        setNav()
        

        
    }
    
    @IBAction func onNewBtnTapped(_ sender: Any) {
        self.index = 1
        orderBtn.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        newBtn.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        mostVisitBtn.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        setNav()
    }
    

    @IBAction func onMostVisitBtn(_ sender: Any) {
        self.index = 2
        orderBtn.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        newBtn.backgroundColor = .white
        mostVisitBtn.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        setNav()
    
    }
    
    @IBAction func onCancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
