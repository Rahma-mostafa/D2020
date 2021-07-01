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

class FavouriteVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subcategoryId = 14
    var SubCategoryStoresArray = [SubCategoryStoresData]()


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        subcategoriesStoresRequest()
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self

    }
    // MARK:- API Request
    func subcategoriesStoresRequest(){
        KRProgressHUD.show()
        print(subcategoryId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/category_stores/\(subcategoryId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SubCategoryStores.self, from: result.data!) else{return}
                self?.SubCategoryStoresArray = apiResponseModel.data
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    

}
extension FavouriteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubCategoryStoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        cell.categoryImageView.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(SubCategoryStoresArray[indexPath.row].image)"))
        cell.nameLabel.text = SubCategoryStoresArray[indexPath.row].name
        cell.rateLabel.text = "12KM"
        return cell
    }
    
}
    
