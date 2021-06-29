//
//  MorePlacesVC.swift
//  D2020
//
//  Created by Macbook on 04/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class MorePlacesVC: UIViewController {
    @IBOutlet weak var placesCollectionView: UICollectionView!
    var storesArray = [StoesDataClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        storesRequest()

    }
    func setup(){
        self.placesCollectionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCell")
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
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
                self?.storesArray = apiResponseModel.data
                self?.placesCollectionView.reloadData()
                print("\(self!.storesArray)")
                KRProgressHUD.dismiss()

            }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
extension MorePlacesVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
        cell.categoryImage.sd_setImage(with: URL(string: storesArray[indexPath.row].image))
        cell.categoryLabel.text = storesArray[indexPath.row].name
        return cell
    }
    
    
}
