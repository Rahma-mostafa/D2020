//
//  HomeVC.swift
//  D2020
//
//  Created by Macbook on 31/05/2021.
//

import UIKit
struct Slider {
    let image: String
}

class HomeVC: UIViewController {

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var placesCollectionView: UICollectionView!
    // variables
    var slider = [Slider(image: "slideShow"),Slider(image: "slideShow"),Slider(image: "slideShow")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        pageView.numberOfPages = slider.count
        pageView.currentPage = -1


    }
    func setup(){
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        self.sliderCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.placesCollectionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCell")
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 300)

     }
    @IBAction func menuBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "MenuVC")
        navigationController?.pushViewController(scene, animated: true)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        scrollView.isScrollEnabled = false
//    }
    


}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView {
            return slider.count
        }else {
            return 6
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
            cell.categoryImage.image = UIImage(named:"sofa")
            cell.categoryLabel.text = "اثاث"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
            cell.categoryImage.image = UIImage(named:"161210018117400060236016b25505e31")
            cell.categoryLabel.text = "دجاج كنتاكي "
            return cell
        }

        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageView.currentPage = indexPath.row
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: ( self.view.frame.size.width) / 3 , height: 97)
//
//    }

    
    
}
