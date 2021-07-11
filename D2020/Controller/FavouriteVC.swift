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
    var savedStoresArray = [SavedStoresData]()
    var storeId = 0



    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getSavedStores()
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self

    }
    // MARK:- API Request
    func getSavedStores(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/saved_stores"
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SavedStores.self, from: result.data!) else{
                return}
                self?.savedStoresArray = apiResponseModel.data
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    @objc func deleteStore(sender:UIButton){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/delete_saved_stores/\(savedStoresArray[sender.tag].id)"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        Alamofire
            .request(apiURL, method: .delete , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم الحذف ")
                    self?.savedStoresArray.remove(at: sender.tag)
                    self?.tableView.reloadData()
                }else{
                    
                    KRProgressHUD.showError(withMessage: "عطل بالسيرفر")
                }
            }

    }
 

// saved stores
}
extension FavouriteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedStoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        cell.categoryImageView.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(savedStoresArray[indexPath.row].image)"))
        cell.nameLabel.text = savedStoresArray[indexPath.row].name
        cell.saveBtn.setTitle("حذف", for: .normal)
        cell.saveBtn.tag = indexPath.row
        cell.saveBtn.addTarget(self, action: #selector(deleteStore), for: .touchUpInside)

        
        return cell
    }


    
}
    
