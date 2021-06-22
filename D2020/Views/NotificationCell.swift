//
//  NotificationCell.swift
//  D2020
//
//  Created by Macbook on 15/06/2021.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var subscripeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onNotificationBtnTapped(_ sender: Any) {
        self.backView.backgroundColor = .white
    }
}
