//
//  ProductVC.swift
//  D2020
//
//  Created by Macbook on 17/06/2021.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        self.productCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    

    
}
extension ProductVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.productImage.image = UIImage(named: "jeremy-ricketts-6ZnhM-xBpos-unsplash@3x")
        cell.nameLabel.text = "قهوة فرنساوي"
        cell.priceLabel.text = "30 ريا ل"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let width = (view.frame.width ) / 3
            return CGSize(width: width , height: 152)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

            return 16
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     
            return 16
        
    }
    
    
    
}
