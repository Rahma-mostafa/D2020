//
//  CategoriesVC.swift
//  D2020
//
//  Created by Macbook on 11/06/2021.
//

import UIKit
import Alamofire
import KRProgressHUD
import SDWebImage


class CategoriesVC: UIViewController {
    

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var SubCategoryTableView: UITableView!

    @IBOutlet weak var noFieldLabel: UILabel!
    //variables
    var categoryArray = [categoriesDataClass]()
    var subcategoryArray = [SubCategoriesData]()
    var categoryId = 0
    var subcategoryId = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        categoriesRequest()
        subCategoriesRequest()
        showNoData()

    }
    func setup(){
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        SubCategoryTableView.delegate = self
        SubCategoryTableView.dataSource = self

        
    }
    func showNoData(){
        if subcategoryArray.isEmpty == true {
            self.noFieldLabel.text = "This category has no subcategory".localized()
        }else{
            self.noFieldLabel.text = ""

        }
    }
  
    
                             // MARK:- Categories Request
    
    
    func categoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/categories"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(Categories.self, from: result.data!) else{return}
                self?.categoryArray = apiResponseModel.data ?? [categoriesDataClass]()
                self?.categoryCollectionView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func subCategoriesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/sub_categories/\(categoryId)"
        print(categoryId)
        guard let apiURL = URL(string: apiURLInString) else{
            return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
//                do{
//                    try jsonConverter.decode(SubCategories.self, from: result.data!)
//                }catch let error {
//                    print("\(error)")
//                }
            guard let apiResponseModel = try? jsonConverter.decode(SubCategories.self, from: result.data!) else{
                print("nil")
                return}
                self?.subcategoryArray = apiResponseModel.data ?? [SubCategoriesData]()
                self?.showNoData()
                self?.SubCategoryTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    
    

    
    
}
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {

    // categories

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(categoryArray[indexPath.row].image ?? "")"
        cell.categoryImageView.sd_setImage(with: URL(string: imageUrl))
        cell.nameLabel.text = categoryArray[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.categoryId = categoryArray[indexPath.row].id ?? 0
        print("categoryId = " +  " \(categoryId)")
        subCategoriesRequest()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 84, height: 84)
    
    }
    // SubcategoryTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubCategoryCell", owner: self, options: nil)?.first as! SubCategoryCell
        let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(subcategoryArray[indexPath.row].image ?? "")"
        cell.categoryImageView.sd_setImage(with: URL(string: imageUrl ))
        cell.nameLabel.text = subcategoryArray[indexPath.row].arabicName
        cell.rateView.isHidden = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.subcategoryId = subcategoryArray[indexPath.row].id ?? 0
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "SubcategoryStoresVC") as!  SubcategoryStoresVC
        scene.subcategoryId = self.subcategoryId
        scene.categoryId = self.categoryId
        navigationController?.pushViewController(scene, animated: true)
        
    }

    
    
    
}

