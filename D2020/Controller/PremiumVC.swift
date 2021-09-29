//
//  PremiumVC.swift
//  D2020
//
//  Created by Macbook on 16/06/2021.
//

import UIKit

class PremiumVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var infoContainerView: UIView!
    
    @IBOutlet weak var worktimeView: UIView!
    
    @IBOutlet weak var socialView: UIView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    
    @IBOutlet weak var rateTableView: UITableView!
    
//    var slider = [Slider(image: "slideShow"),Slider(image: "slideShow"),Slider(image: "slideShow")]
//    var timer = Timer()
//    var counter = 0
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        pageView.numberOfPages = slider.count
//        pageView.currentPage = 0
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
//        }
//        infoContainerView.isHidden = false
//
//    }
//    func setup(){
//        sliderCollectionView.dataSource = self
//        sliderCollectionView.delegate = self
//        self.sliderCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
//        serviceCollectionView.dataSource = self
//        serviceCollectionView.delegate = self
//        self.serviceCollectionView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
//        brandCollectionView.dataSource = self
//        brandCollectionView.delegate = self
//        self.brandCollectionView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
//        rateTableView.dataSource = self
//        rateTableView.delegate = self
//
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 300)
//
//     }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @objc func changeImage() {
//
//     if counter < slider.count {
//         let index = IndexPath.init(item: counter, section: 0)
//         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//         pageView.currentPage = counter
//         counter += 1
//     } else {
//         counter = 0
//         let index = IndexPath.init(item: counter, section: 0)
//         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
//         pageView.currentPage = counter
//         counter = 1
//     }
//     }
//
//    @IBAction func onInfoBtnTapped(_ sender: Any) {
//        infoContainerView.isHidden = false
//        worktimeView.isHidden = true
//        socialView.isHidden = true
//
//
//    }
//    @IBAction func onWorkTimeBtnTapped(_ sender: Any) {
//        worktimeView.isHidden = false
//        infoContainerView.isHidden = true
//        socialView.isHidden = true
//
//
//    }
//
//
//    @IBAction func onContactBtn(_ sender: Any) {
//        socialView.isHidden = false
//        worktimeView.isHidden = true
//        infoContainerView.isHidden = true
//
//    }
//
//
//
//}
//extension PremiumVC: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == sliderCollectionView {
//            return slider.count
//
//        }else{
//            return 6
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == sliderCollectionView{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
//            cell.backgroundImage.image = UIImage(named: slider[indexPath.row].image)
//            return cell
//
//        }else if collectionView == serviceCollectionView{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
//            cell.serviceImage.image = UIImage(named: "wifi@-3")
//            cell.nameLabel.text = "واي فاي "
//            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
//            cell.serviceImage.image = UIImage(named: "W69u1zLX_400x400@3x")
//            cell.serviceImage.backgroundColor = .clear
//            cell.serviceImage.contentMode = .scaleToFill
//            cell.nameLabel.text = "بيبسي "
//            return cell
//        }
//
//    }
//}
//extension PremiumVC: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == sliderCollectionView{
//            let size = sliderCollectionView.frame.size
//            return CGSize(width: size.width, height: size.height)
//        }else {
//            let width = (view.frame.width ) / 5
//            return CGSize(width: width , height: 152)
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == sliderCollectionView{
//            return 0.0
//
//        }else{
//            return 16
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == sliderCollectionView{
//            return 0.0
//
//        }else{
//            return 16
//        }
//    }
//}
//extension PremiumVC: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = Bundle.main.loadNibNamed("RateCell", owner: self, options: nil)?.first as! RateCell
//        cell.userImage.image = UIImage(named: "avatar@3x")
//        cell.nameLabel.text = "maher ben naif"
//        cell.commentLAbel.text = "جميل جدا"
//        cell.rateView.rating = 4
//        if indexPath.row == 0{
//            cell.titleLabel.text = "تقيمك"
//        }else if indexPath.row == 1{
//            cell.titleLabel.text = "كل التقيمات"
//        }else{
//            cell.titleLabel.text = ""
//        }
//        return cell
//    }
//
//
}
//
//
