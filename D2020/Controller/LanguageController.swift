//
//  LanguageController.swift
//  D2020
//
//  Created by Macbook on 29/05/2021.
//

import UIKit
import Alamofire
import KRProgressHUD

struct Country {
    var image: String?
    var name: String?
}

class LanguageController: BaseController {
   
    @IBOutlet weak var countryTblView: UITableView!
    // variables
    var country = [Country(image: "2000px-Flag_of_Egypt.svg", name: "مصر"),Country(image: "2000px-Flag_of_Egypt.svg", name: "مصر"),Country(image: "2000px-Flag_of_Egypt.svg", name: "مصر"),Country(image: "2000px-Flag_of_Egypt.svg", name: "مصر")]
    var citiesArray = [CitiesDataClass]()
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.hiddenNav = true
        citiesRequest()
    }
    func setup(){
        countryTblView.dataSource = self
        countryTblView.delegate = self

    }
    func citiesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/cities"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Cities.self, from: result.data!) else{return}
                self?.citiesArray = apiResponseModel.data
                self?.countryTblView.reloadData()
                print("\(self!.citiesArray)")
                KRProgressHUD.dismiss()

            }
    }
    


}

extension LanguageController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "sbBlue") as SplashController
        navigationController?.pushViewController(scene, animated: true)
        selectedIndex = indexPath.row
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CountryCell", owner: self, options: nil)?.first as! CountryCell
        if indexPath.row % 2 == 0 {
            cell.background.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else if indexPath.row == selectedIndex {
            cell.background.backgroundColor = #colorLiteral(red: 0.9495897889, green: 0.6210864186, blue: 0.2001613379, alpha: 1)
        }else{
            cell.background.backgroundColor = .white
        }
//            cell.countryImage.image = UIImage(named: country[indexPath.row].image ?? "" )
        cell.countryName.text = citiesArray[indexPath.row].name
            return cell
    }

   
    
    
}
