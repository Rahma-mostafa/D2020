//
//  WorkTimeVC.swift
//  D2020
//
//  Created by Macbook on 19/06/2021.
//

import UIKit
struct Days {
    var day: String
}

class WorkTimeVC: UIViewController {
    

    @IBOutlet weak var workTimeCollectionView: UICollectionView!
    // variables
   var  daysArray   = [Days(day: "السبت"),Days(day:"الاحد"),Days(day:"الاثنين"),Days(day: "الثلاثاء"),Days(day: "الاربعاء"),Days(day:"الخميس"),Days(day: "الجمعة")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        workTimeCollectionView.delegate = self
        workTimeCollectionView.dataSource = self
        self.workTimeCollectionView.register(UINib(nibName: "WorkTimeCell", bundle: nil), forCellWithReuseIdentifier: "WorkTimeCell")

    }
    

}
extension WorkTimeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkTimeCell", for: indexPath) as! WorkTimeCell
        cell.dayLabel.text = daysArray[indexPath.row].day
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (view.frame.width ) / 5
            return CGSize(width: width , height: 50)
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    
    
}
