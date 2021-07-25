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
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var storesCollectionView: UICollectionView!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuForOwnerContainerView: UIView!
    // variables
    var slider = [Slider(image: "header_login"),Slider(image: "b1"),Slider(image: "b2")]
    var categoryArray = [categoriesDataClass]()
    var storesArray = [StoesDataClass]()
    var timer = Timer()
    var counter = 0
    var iconClick = true
    var storeId = 0
//    var type = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        storesRequest()
        categoriesRequest()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        self.blurView.isHidden = true
        self.menuContainerView.isHidden = true
    }
    
    @objc func changeImage() {
        if counter < slider.count - 1 {
            counter += 1
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToNextItem()
            pageView.currentPage = counter
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
        }
        
    }
    
    func setup(){
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        self.sliderCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.categoryCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.storesCollectionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCell")
        storesCollectionView.delegate = self
        storesCollectionView.dataSource = self
        pageView.numberOfPages = slider.count
        pageView.currentPage = 0
        
    }
    func setBlur(){
        self.blurView.isHidden = false
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 0.5
        view.addSubview(blurView)

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 150)
        
    }
    @IBAction func menuBtnTapped(_ sender: Any) {
        if(iconClick == true){
//            setBlur()
            self.menuContainerView.isHidden = false
        }else{
            self.menuContainerView.isHidden = true
        }
        iconClick = !iconClick
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
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/best_stores"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(Stores.self, from: result.data!) else{return}
                self?.storesArray = apiResponseModel.data?.data ?? [StoesDataClass]()
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
            return cell
        }else if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(categoryArray[indexPath.row].image ?? "" )"
            cell.categoryImageView.sd_setImage(with: URL(string: imageUrl))
            cell.nameLabel.text = categoryArray[indexPath.row].name
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
            let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(storesArray[indexPath.row].image ?? "")"
            cell.categoryImage.sd_setImage(with: URL(string: imageUrl))
            cell.categoryLabel.text = storesArray[indexPath.row].name
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            let storyboard = UIStoryboard(name: "Category", bundle: nil)
            let scene = storyboard.instantiateViewController(withIdentifier: "CategoriesVC")
            navigationController?.pushViewController(scene, animated: true)
        }else if collectionView == storesCollectionView{
            self.storeId = storesArray[indexPath.row].id ?? 0
            let storyboard = UIStoryboard(name: "Category", bundle: nil)
            let scene = storyboard.instantiateViewController(withIdentifier: "SingleStoreDetailsVC") as!  SingleStoreDetailsVC
            scene.storeId = self.storeId
            navigationController?.pushViewController(scene, animated: true)

        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if collectionView == sliderCollectionView{
//            self.pageView.currentPage = indexPath.item
//        }
    }
    
    
    
    
    
}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + (self.bounds.size.width * 0.90)))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
