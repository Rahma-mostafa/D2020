//
//  HomeVC.swift
//  D2020
//
//  Created by Macbook on 31/05/2021.
//

import UIKit
import Alamofire
import SDWebImage
import KRProgressHUD
struct Slider {
    let image: String
}

class HomeVC: UIViewController {

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var storesCollectionView: UICollectionView!
    // variables
    var slider = [Slider(image: "slideShow"),Slider(image: "slideShow"),Slider(image: "slideShow")]
    var categoryArray = [categoriesDataClass]()
    var storesArray = [StoesDataClass]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        storesRequest()
        categoriesRequest()


    }
    func setup(){
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        self.sliderCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.storesCollectionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCell")
        storesCollectionView.delegate = self
        storesCollectionView.dataSource = self
        pageView.numberOfPages = slider.count
        pageView.currentPage = -1

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 300)

     }
    @IBAction func menuBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "MenuVC")
        navigationController?.pushViewController(scene, animated: true)
    }
    

    // MARK:- API Request
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
                KRProgressHUD.dismiss()

            }
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
                self?.storesCollectionView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    


}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView {
            return slider.count
        }else if collectionView == categoryCollectionView{
            return categoryArray.count
        }else{
            return storesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            cell.backgroundImage.image = UIImage(named: slider[indexPath.row].image)
    //        cell.helloLabel.text = "Hello"
    //        cell.nameLabel.text = "Maher"
    //        cell.logoName.text = "welcome in D202"
            return cell
        }else if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categoryImage.sd_setImage(with: URL(string: categoryArray[indexPath.row].image))
            cell.categoryLabel.text = categoryArray[indexPath.row].name
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
            cell.categoryImage.sd_setImage(with: URL(string: storesArray[indexPath.row].image))
            cell.categoryLabel.text = storesArray[indexPath.row].name
            return cell
        }

        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            let storyboard = UIStoryboard(name: "Category", bundle: nil)
            let scene = storyboard.instantiateViewController(withIdentifier: "CategoriesVC")
            navigationController?.pushViewController(scene, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageView.currentPage = indexPath.row
    }



    
    
}
