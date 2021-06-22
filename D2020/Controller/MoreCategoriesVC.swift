//
//  MoreCategoriesVC.swift
//  D2020
//
//  Created by Macbook on 04/06/2021.
//

import UIKit

class MoreCategoriesVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        self.categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    


}
extension MoreCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categoryImage.image = UIImage(named:"sofa")
            cell.categoryLabel.text = "اثاث"
            return cell
    }
    
    
}
