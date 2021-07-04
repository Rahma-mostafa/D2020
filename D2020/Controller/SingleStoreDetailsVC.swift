//
//  CategoryDetailsVC.swift
//  D2020
//
//  Created by Macbook on 16/06/2021.
//

import UIKit
import Cosmos
import Alamofire
import KRProgressHUD
import SDWebImage

class SingleStoreDetailsVC: UIViewController {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var storeImageView: UIImageView!
    
    @IBOutlet weak var storeNameLbl: UILabel!
    
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    var slider = [Slider(image: "slideShow"),Slider(image: "slideShow"),Slider(image: "slideShow")]
    var timer = Timer()
    var counter = 0
    var storeId = 7
    var storeDetailsArray = [Review]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        pageView.numberOfPages = slider.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        singleStoreDetailsRequest()

      
    }
    func setup(){
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        self.sliderCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        self.productCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        commentTableView.dataSource = self
        commentTableView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 1000)

     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeImage() {
     
     if counter < slider.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageView.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageView.currentPage = counter
         counter = 1
     }
         
     }
    // MARK:- API Request
    func singleStoreDetailsRequest(){
        KRProgressHUD.show()
        print(storeId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/7"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
            let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                    KRProgressHUD.dismiss()
                    return}
                self?.storeDetailsArray = apiResponseModel.data?.reviews ?? [Review]()
                print(self?.storeDetailsArray)
                self?.commentTableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    
    

    
}
extension SingleStoreDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView {
            return slider.count

        }else{
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            cell.backgroundImage.image = UIImage(named: slider[indexPath.row].image)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.productImage.image = UIImage(named: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x")
            cell.nameLabel.text = "قهوة فرنساوي"
            cell.priceLabel.text = "30 ريا ل"
            return cell
        }
    }
    
    
}
extension SingleStoreDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView{
            let size = sliderCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }else{
            let width = (view.frame.width ) / 3
            return CGSize(width: width , height: 152)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sliderCollectionView{
            return 0.0

        }else{
            return 16
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sliderCollectionView{
            return 0.0

        }else{
            return 16
        }
    }
}
extension SingleStoreDetailsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeDetailsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RateCell", owner: self, options: nil)?.first as! RateCell
        cell.userImage.image = UIImage(named: "avatar@3x")
        cell.nameLabel.text = storeDetailsArray[indexPath.row].username
        cell.commentLAbel.text = "جميل جدا"
        cell.rateView.rating = 4
        if indexPath.row == 0{
            cell.titleLabel.text = "تقيمك"
        }else if indexPath.row == 1{
            cell.titleLabel.text = "كل التقيمات"
        }else{
            cell.titleLabel.text = ""
        }
        return cell
    }
}

