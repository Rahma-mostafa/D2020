//
//  AboutVC.swift
//  D2020
//
//  Created by Macbook on 12/07/2021.
//

import UIKit
import KRProgressHUD
import Alamofire

class AboutVC: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    var about = [AboutDataClass]()

    override func viewDidLoad() {
        super.viewDidLoad()

        descreptionRequest()
        
    }
    func descreptionRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/about"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(About.self, from: result.data!) else{return}
                self?.descLabel.text = apiResponseModel.data.content
                KRProgressHUD.dismiss()

            }
    }
    

   
}
