//
//  ContactVC.swift
//  D2020
//
//  Created by Macbook on 20/06/2021.
//

import UIKit

class ContactVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        tableview.delegate = self
        tableview.dataSource = self
    }
    

   

}
extension ContactVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ContactCell", owner: self, options: nil)?.first as! ContactCell
        cell.logoImage.image = UIImage(named:"facebook (3)")
        cell.sociallabel.text = "حساب فيسبوك"
        return cell
    }
    
    
}
