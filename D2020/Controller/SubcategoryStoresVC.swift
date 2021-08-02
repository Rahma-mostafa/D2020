//
//  AllSubCategoriesVC.swift
//  D2020
//
//  Created by Macbook on 13/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage


class SubcategoryStoresVC: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var StoresTableView: UITableView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var citiesTableView: UITableView!
    //variables
    var citiesArray = [CitiesDataClass]()
    var subcategoryId = 0
    var SubCategoryStoresArray = [SubCategoryStoresData]()
    var cityStoresArray = [CityStoresDetails]()
    var index = 3
    var storeId = 0
    var cityId = 0
    var iconClick = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        subcategoriesStoresRequest()
        filterStores()
        print("orderIndex = \(index)")
        citiesRequest()
        self.filterContainerView.isHidden = true

       
    }
    func setup(){
        StoresTableView.delegate = self
        StoresTableView.dataSource = self
        cityView.isHidden = true
        citiesTableView.delegate = self
        citiesTableView.dataSource = self

    }
    func filterStores(){
        if index == 0{
            descStoresRequest()
        }else if index == 1{
            ascStoresRequest()
        }else if index == 2{
            mostViewsStoresRequest()
        }else{
            subcategoriesStoresRequest()
        }
    }
    // MARK:- API Request
    func subcategoriesStoresRequest(){
        KRProgressHUD.show()
        print("subcategoryId = \(subcategoryId)")
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/category_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
               
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data ?? [SubCategoryStoresData]()
                self?.StoresTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func descStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/desc_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data ?? [SubCategoryStoresData]()
                self?.StoresTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func ascStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/asc_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data ?? [SubCategoryStoresData]()
                self?.StoresTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func mostViewsStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/most_views_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data ?? [SubCategoryStoresData]()
                self?.StoresTableView.reloadData()
                KRProgressHUD.dismiss()

            }
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
                self?.citiesTableView.reloadData()
                print("\(self!.citiesArray)")
                KRProgressHUD.dismiss()

            }
    }
    func cityStores(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/city_stores/\(cityId)"
        print("citiyId = \(cityId)")

        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(CityStores.self, from: result.data!) else{
                return}
                self?.cityStoresArray = apiResponseModel.data?.data ?? [CityStoresDetails]()
                self?.StoresTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }

    
    @IBAction func onFilterBtnTapped(_ sender: Any) {
        if(iconClick == true){
            self.filterContainerView.isHidden = false
        }else{
            self.filterContainerView.isHidden = true
             }
          iconClick = !iconClick

        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OrderFilterVC,
            segue.identifier == "filter" {
            vc.subcategoryId = self.subcategoryId
            }
    }
     
    
    
    


}
extension SubcategoryStoresVC:  UITextFieldDelegate ,UITableViewDelegate,UITableViewDataSource{
    

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.cityView.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.textBox {
            self.cityView.isHidden = true
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
 @IBAction func onDropButtonTapped(_ sender: Any) {
     if self.cityView.isHidden == true{
         self.cityView.isHidden = false
     }else{
         self.cityView.isHidden = true
     }
 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.StoresTableView{
            return SubCategoryStoresArray.count
        }else{
            return citiesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.StoresTableView{
            let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
            cell.categoryImageView.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(SubCategoryStoresArray[indexPath.row].image)"))
            cell.nameLabel.text = SubCategoryStoresArray[indexPath.row].name
            cell.rateView.rating = Double(SubCategoryStoresArray[indexPath.row].rating ?? 0)
            cell.rateView.isUserInteractionEnabled = false
            return cell
        }else{
            let cell = citiesTableView.dequeueReusableCell(withIdentifier: "CitiesCell", for: indexPath) as! CitiesCell
            cell.cityLabel.text = citiesArray[indexPath.row].name
            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.StoresTableView{
            self.storeId = SubCategoryStoresArray[indexPath.row].id ?? 1
            let storyboard = UIStoryboard(name: "Category", bundle: nil)
            let scene = storyboard.instantiateViewController(withIdentifier: "SingleStoreDetailsVC") as!  SingleStoreDetailsVC
            scene.storeId = self.storeId
            navigationController?.pushViewController(scene, animated: true)
        }else{
            self.cityId = citiesArray[indexPath.row].id
            self.textBox.text = citiesArray[indexPath.row].name
            cityStores()
            self.cityView.isHidden = true
        }
       
        
    }

}
