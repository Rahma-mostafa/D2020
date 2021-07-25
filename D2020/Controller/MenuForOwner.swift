//
//  MenuForOwner.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit

class MenuForOwner: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
    }
    

   
}
