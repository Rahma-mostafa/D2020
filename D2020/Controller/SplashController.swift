//
//  splashController.swift
//  D2020
//
//  Created by Macbook on 28/05/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class SplashController: BaseController {

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var splashImageView: UIImageView!
    var imagesArray = [SplashData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
//        getSplashImage()
    }
    func getSplashImage(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/splashes"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Splash.self, from: result.data!) else{return}
                self?.imagesArray = apiResponseModel.data
                let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(self?.imagesArray[0].image ?? "")"
                self?.splashImageView.sd_setImage(with: URL(string: imageUrl))
                KRProgressHUD.dismiss()

            }
    }
    @IBAction func onSkip(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "LanguageController") as? LanguageController
        navigationController?.pushViewController(scene!, animated: true)
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SigninVC") as? SigninVC
        navigationController?.pushViewController(scene!, animated: true)
    }
    
    

   
}
