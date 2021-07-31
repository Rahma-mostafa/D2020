//
//  OwnerStoresVC.swift
//  D2020
//
//  Created by Macbook on 25/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage
import Cosmos

class OwnerStoresVC: UIViewController {

    @IBOutlet weak var OwnerStoresTableView: UITableView!
    var savedStoresArray = [StoreData]()
    var storeId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getSavedStores()

    }
    func setup(){
        OwnerStoresTableView.delegate = self
        OwnerStoresTableView.dataSource = self
    }
    // MARK:- API Request
    func getSavedStores(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores"
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json"]
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(OwnerStores.self, from: result.data!) else{
                return}
                self?.savedStoresArray.append(contentsOf: apiResponseModel.data.stores)
                self?.OwnerStoresTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    @objc func deleteStore(sender:UIButton){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores/destroy/\(savedStoresArray[sender.tag].id)"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json"]
        Alamofire
            .request(apiURL, method: .delete , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم الحذف ")
                    self?.savedStoresArray.remove(at: sender.tag)
                    self?.OwnerStoresTableView.reloadData()
                }else{
                    
                    KRProgressHUD.showError(withMessage: "عطل بالسيرفر")
                }
            }

    }
    @objc func editStore(sender:UIButton){
        let storyboard = UIStoryboard(name: "Owner", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "AddProductVC") as? AddProductVC
        scene.action = "edit"
        navigationController?.pushViewController(scene!, animated: true)
    }
    

   
    

}
extension OwnerStoresVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedStoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        cell.categoryImageView.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(savedStoresArray[indexPath.row].image)"))
        cell.nameLabel.text = savedStoresArray[indexPath.row].name
        cell.saveBtn.isUserInteractionEnabled = false
        cell.deleteBtn.setTitle("حذف", for: .normal)
        cell.editButton.setTitle("تعديل", for: .normal)
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteStore), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editStore), for: .touchUpInside)
        cell.rateView.isUserInteractionEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.storeId = savedStoresArray[indexPath.row].id ?? 0
        let storyboard = UIStoryboard(name: "Owner", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "OwnerStoreDetailsVC") as? OwnerStoreDetailsVC
        scene?.storeId = self.storeId
        navigationController?.pushViewController(scene!, animated: true)
    }
   
    
    
}
