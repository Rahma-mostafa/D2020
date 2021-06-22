//
//  NotificationVC.swift
//  D2020
//
//  Created by Macbook on 16/06/2021.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        notificationTableView.delegate = self
        notificationTableView.dataSource = self

    }
    

   
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NotificationCell", owner: self, options: nil)?.first as! NotificationCell
        cell.notificationImage.image = UIImage(named: "Ellipse 40")
        cell.notificationTitle.text = "هناك طلب مرسل لك"
        cell.subscripeLabel.text = "هناك طلب مرسل لك"
        cell.timeLabel.text = "منذ دقيقتين"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}
