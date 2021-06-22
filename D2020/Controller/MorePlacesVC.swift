//
//  MorePlacesVC.swift
//  D2020
//
//  Created by Macbook on 04/06/2021.
//

import UIKit

class MorePlacesVC: UIViewController {
    @IBOutlet weak var placesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        self.placesCollectionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: "PlacesCell")
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
extension MorePlacesVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
        cell.categoryImage.image = UIImage(named:"161210018117400060236016b25505e31")
        cell.categoryLabel.text = "دجاج كنتاكي "
        return cell
    }
    
    
}
