//
//  OwnerStoreDetailsVC.swift
//  D2020
//
//  Created by Macbook on 16/07/2021.
//

import UIKit
import Cosmos
import Alamofire
import KRProgressHUD
import SDWebImage

class OwnerStoreDetailsVC: UIViewController {
    @IBOutlet weak var storeimageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var DescribeLabel: UILabel!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var reviewsNumLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var reviewsAvarageView: CosmosView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userRatingView: CosmosView!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var postBtn: UIButton!
    var slider = [Slider(image: "slideShow"),Slider(image: "slideShow"),Slider(image: "slideShow")]
    var timer = Timer()
    var counter = 0
    var storeId = 0
    var reviewArray = [Review]()
    var dataDetials = [DataData]()
    var productArray = [Offer]()
    var imagesArray = [Image]()
    var reviewsAvarage  = 0.0
    var phoneNumber = ""
    var avarage: Double? = nil
    var imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        pageView.numberOfPages = imagesArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        self.reviewsAvarageView.isUserInteractionEnabled = false
        storeDetailsRequest()
        getRestStoreDetialsRequest()
        photoRequest()
        userProfileRequest()

       
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
        userRatingView.settings.updateOnTouch = true
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        self.photoCollectionView.register(UINib(nibName: "AddPhotoCell", bundle: nil), forCellWithReuseIdentifier: "AddPhotoCell")
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 1000)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func changeImage() {
        if imagesArray.count == 0{
            return
        }
        if counter < imagesArray.count {
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
    @objc func chooseImage(){
        let imageSelectionAlert = UIAlertController(title: "اختار مصدر الصورة".localized(), message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "الكاميرا".localized(), style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "معرض الصور".localized(), style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "الغاء".localized(), style: .cancel)
        imageSelectionAlert.addAction(cameraAction)
        imageSelectionAlert.addAction(galleryAction)
        imageSelectionAlert.addAction(cancelAction)
        imageSelectionAlert.popoverPresentationController?.sourceView = self.view
        
        self.present(imageSelectionAlert, animated: true, completion: nil)
    }
    func openCamera(){
        imagePicker.sourceType = .camera
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    //MARK:- API requests
    func storeDetailsRequest(){
        KRProgressHUD.show()
        print(storeId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/\(storeId)"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                    return}
                self?.reviewArray = apiResponseModel.data?.reviews ?? [Review]()
                self?.commentTableView.reloadData()
                self?.productArray = apiResponseModel.data?.offers ?? [Offer]()
                self?.productCollectionView.reloadData()
                self?.imagesArray = apiResponseModel.data?.images ?? [Image]()
                self?.sliderCollectionView.reloadData()
                self?.photoCollectionView.reloadData()
                self?.storeId = apiResponseModel.data?.data?.id ?? 0
                self?.phoneNumber = apiResponseModel.data?.data?.phone ?? ""
                KRProgressHUD.dismiss()
                
            }
    }
    func photoRequest(){
        KRProgressHUD.show()
        print(storeId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/\(storeId)"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                    return}
                self?.imagesArray = apiResponseModel.data?.images ?? [Image]()
                self?.photoCollectionView.reloadData()
                KRProgressHUD.dismiss()
                
            }
    }

    func getRestStoreDetialsRequest(){
        KRProgressHUD.show()
        print(" Owner store id + \(storeId)")
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/\(storeId)"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                    return}
                let imageUrl = URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(apiResponseModel.data?.data?.image ?? "")")
                self?.storeNameLbl.text = apiResponseModel.data?.data?.name
                self?.DescribeLabel.text = apiResponseModel.data?.data?.arabicDescription
                self?.storeimageView.sd_setImage(with: imageUrl, completed: nil)
                self?.reviewsAvarageView.rating = Double(apiResponseModel.data?.data?.rating ?? 0 )
                self?.reviewsNumLabel.text = String(apiResponseModel.data?.data?.views ?? 0 )
                self?.rateLabel.text = String(apiResponseModel.data?.data?.views ?? 0 )
                KRProgressHUD.dismiss()
                
            }
    }

    func addStoreReview(){
        KRProgressHUD.show()
        let userReview = reviewTextField.text
        let userRating = self.userRatingView.rating
        let requestParameters = ["rating": userRating ,"review": userReview ?? ""] as [String : Any]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/add_store_review/\(storeId)"
        print("URL : \(apiURLInString)")
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم")
                }else{
                    KRProgressHUD.showError(withMessage: "لم يتم نشر التعليق")
                }
                
            }
    }
    func userProfileRequest(){
        KRProgressHUD.show()
        let userProfileInJson = UserDefaults.standard.data(forKey: UserDefaultKey.USER_PROFILE.rawValue)
        let jsonConverter = JSONDecoder()
        guard let apiResponseModel = try? jsonConverter.decode(LoginResponse.self, from: userProfileInJson!) else{return}
        self.userNameLabel.text = apiResponseModel.data.name ?? ""
        let imageUrl = "\(apiResponseModel.data.photo ?? "")"
        self.userImageView.sd_setImage(with: URL(string: imageUrl))
        KRProgressHUD.dismiss()

    }
    func saveStore(){
        KRProgressHUD.show()
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/save_store/\(storeId)"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage:"تم حفظ المحل ")
                }else{
                    return
                }
                
            }
    }
//    @objc func deleteStore(sender:UIButton){
//        KRProgressHUD.show()
//        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/stores/destroy/\(savedStoresArray[sender.tag].id)"
//        guard let apiURL = URL(string: apiURLInString) else{   return }
//        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
//        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json"]
//        Alamofire
//            .request(apiURL, method: .delete , parameters: nil, encoding: URLEncoding.default, headers: headers)
//            .response {[weak self] result in
//                print("Response Code : \(result.response?.statusCode)")
//                if result.response?.statusCode == 200{
//                    KRProgressHUD.showSuccess(withMessage: "تم الحذف ")
//                    self?.savedStoresArray.remove(at: sender.tag)
//                    self?.photoCollectionView.reloadData()
//                }else{
//
//                    KRProgressHUD.showError(withMessage: "عطل بالسيرفر")
//                }
//            }
//
//    }
    //MARK:- Buttons Action
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
        saveStore()
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "FavouriteVC") as!  FavouriteVC
        scene.storeId = self.storeId
        navigationController?.pushViewController(scene, animated: true)
        
    }
    
    @IBAction func onShareBtnTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems:["www.google.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
   
    
    @IBAction func onCallBtnTapped(_ sender: Any) {
        let appURL = URL(string: "tel://\( phoneNumber )")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    
    @IBAction func onMsgBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Owner", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "ChooseChatWithVC") as!  ChooseChatWithVC
        navigationController?.pushViewController(scene, animated: true)
    }
    @IBAction func onMapBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "MapVC") as!  MapVC
        scene.storeId = self.storeId
        navigationController?.pushViewController(scene, animated: true)
    }
    @IBAction func onPostBtnTapped(_ sender: Any) {
        addStoreReview()
        storeDetailsRequest()
        self.commentTableView.reloadData()
    }
    @IBAction func onAddPhotoBtnTapped(_ sender: Any) {
        chooseImage()
    }
    
    @IBAction func onAddVideoBtnTapped(_ sender: Any) {
        chooseImage()
        
    }
   
    @IBAction func onAddProductBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Owner", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "AddProductVC") as!  AddProductVC
        scene.storeId = self.storeId
        navigationController?.pushViewController(scene, animated: true)
        
    }
    
    
   
    
   
}
// slider and product collection view
extension OwnerStoreDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView {
            return imagesArray.count
            
        }else if collectionView == productCollectionView{
            return productArray.count
        }else{
            return imagesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(imagesArray[indexPath.row].image ?? "")"
            cell.backgroundImage.sd_setImage(with: URL(string: imageUrl))
            return cell
        }else if collectionView == productCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let imageUrl = URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(productArray[indexPath.row].image ?? "")")
            cell.productImage.sd_setImage(with: imageUrl, completed: nil)
            cell.nameLabel.text = productArray[indexPath.row].name
            cell.priceLabel.text = productArray[indexPath.row].price
            cell.offerLabel.text = productArray[indexPath.row].offer ?? ""

            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath) as! AddPhotoCell
            let imageUrl = "\(APIConstant.BASE_IMAGE_URL.rawValue)\(imagesArray[indexPath.row].image ?? "")"
            cell.photo.sd_setImage(with: URL(string: imageUrl))
            cell.deleteBtn.tag = indexPath.item
//            cell.deleteBtn.addTarget(self, action: #selector(deleteStore), for: .touchUpInside)
            return cell
        }
    }

 

    
    
}
extension OwnerStoreDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView{
            let size = sliderCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }else if collectionView == productCollectionView{
            let width = (view.frame.width ) / 3
            return CGSize(width: width , height: 180
            )
        }else{
            let width = (view.frame.width ) / 3
            return CGSize(width: width , height: 116
            )
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
// reviews
extension OwnerStoreDetailsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RateCell", owner: self, options: nil)?.first as! RateCell
        cell.userImage.sd_setImage(with: URL(string: "\(APIConstant.BASE_IMAGE_URL.rawValue)\(reviewArray[indexPath.row].image ?? "")"), completed: nil)
        cell.commentLAbel.text = reviewArray[indexPath.row].review
        cell.rateView.rating = Double(reviewArray[indexPath.row].rating ?? 0)
        cell.rateView.isUserInteractionEnabled = false
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


