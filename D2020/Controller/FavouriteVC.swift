//
//  FavouriteVC.swift
//  D2020
//
//  Created by Macbook on 01/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage
struct SavedStoreDetails{
    var name: String
    var image: String
}
class FavouriteVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subcategoryId = 14
    var SubCategoryStoresArray = [SubCategoryStoresData]()
    var savedStoresArray = [SavedStoreDetails]()
    var storeId = 7
    let jsonDecoder = JSONDecoder()



    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        subcategoriesStoresRequest()
        getSavedStores()
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self

    }
    // MARK:- API Request

     func getSavedStores(){
             KRProgressHUD.show()
             print(storeId)
             let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/\(storeId)"
             guard let apiURL = URL(string: apiURLInString) else{   return }
             Alamofire
                 .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
                 .response {[weak self] result in
                 let jsonConverter = JSONDecoder()
                     guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                         return}
                    let name = apiResponseModel.data?.data?.name
                    let image = apiResponseModel.data?.data?.image
                    let storeObj = SavedStoreDetails(name: name ?? "", image: image ?? "")
                    self?.savedStoresArray.append(storeObj)
                    self?.tableView.reloadData()
                    KRProgressHUD.dismiss()

                }
    }
//    private func decodeFavStoresSaved(){
//        let favStores = UserDefaults.standard.data(forKey: "favStores")
//        if favStores != nil{
//            favStores = try! jsonDecoder.decode([StoreDetails].self, from: favStores!)
//        }
//    }
//

}
extension FavouriteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedStoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        cell.categoryImageView.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(savedStoresArray[indexPath.row].image)"))
//          cell.rateLabel.text = "12KM"
          cell.nameLabel.text = savedStoresArray[indexPath.row].name

        
        return cell
    }
    
}
    
