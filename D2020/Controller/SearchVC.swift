//
//  SearchVC.swift
//  D2020
//
//  Created by Macbook on 12/07/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage


class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var storeTableView: UITableView!
    var storesArray = [StoesDataClass]()
    var currentStoresArray = [StoesDataClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        storesRequest()

    }
    func setup(){
        storeTableView.delegate = self
        storeTableView.dataSource = self
        searchBar.delegate = self
        currentStoresArray = storesArray
        
    }
    func storesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/stores"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Stores.self, from: result.data!) else{return}
                self?.storesArray = apiResponseModel.data ?? [StoesDataClass]()
                self?.storeTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    

   
}
extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NotificationCell", owner: self, options: nil)?.first as! NotificationCell
        let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(currentStoresArray[indexPath.row].image ?? "")"
        cell.notificationImage.sd_setImage(with: URL(string: imageUrl ))
        cell.notificationTitle.text = currentStoresArray[indexPath.row].name
        cell.subscripeLabel.text = currentStoresArray[indexPath.row].datumDescription
        cell.timeLabel.text = ""
        return cell


    }
    
    
}
extension SearchVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        currentStoresArray = searchText.isEmpty ? storesArray : storesArray.filter({StoesDataClass -> Bool in
            return currentStoresArray.contains { _ in searchText == StoesDataClass.name }

        })
        self.storeTableView.reloadData()
    }


    
}
