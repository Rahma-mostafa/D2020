//
//  MoreCategoriesVC.swift
//  D2020
//
//  Created by Macbook on 04/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage

class MoreCategoriesVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    // variables
    var categoryArray = [categoriesDataClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        categoriesRequest()

    }
    func setup(){
        self.categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    func categoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/categories"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Categories.self, from: result.data!) else{return}
                self?.categoryArray = apiResponseModel.data
                self?.categoryCollectionView.reloadData()
                print("\(self!.categoryArray)")
                KRProgressHUD.dismiss()

            }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    


}
extension MoreCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryImage.sd_setImage(with: URL(string: categoryArray[indexPath.row].image))
        cell.categoryLabel.text = categoryArray[indexPath.row].name
            return cell
    }
    
    
}
