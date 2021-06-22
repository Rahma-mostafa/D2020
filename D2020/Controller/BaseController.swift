//
//  BaseController.swift
//  D2020
//
//  Created by Macbook on 28/05/2021.
//

import UIKit

class BaseController: UIViewController {
    var hiddenNav: Bool = false
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        setActivityIndicator()
        
    }
    func setActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .black
        self.view.addSubview(activityIndicator)
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           if self.hiddenNav {
               // Show the Navigation Bar
               self.navigationController?.setNavigationBarHidden(true, animated: false )
               self.navigationController?.navigationBar.shadowImage = UIImage()

           } else {
               self.navigationController?.setNavigationBarHidden(false, animated: false)
           }
    
        
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           //baseViewModel = nil
           if self.hiddenNav {
               // Show the Navigation Bar
               self.navigationController?.setNavigationBarHidden(true, animated: false)
               self.navigationController?.navigationBar.shadowImage = UIImage()

           } else {
               self.navigationController?.setNavigationBarHidden(false, animated: false)
           }
       }

}
extension UIView {

    /// The ratio (from 0.0 to 1.0, inclusive) of the view's corner radius
    /// to its width. For example, a 50% radius would be specified with
    /// `cornerRadiusRatio = 0.5`.
    public var cornerRadiusRatio: CGFloat {
        get {
            return layer.cornerRadius / frame.width
        }

        set {
            // Make sure that it's between 0.0 and 1.0. If not, restrict it
            // to that range.
            let normalizedRatio = max(0.0, min(1.0, newValue))
            layer.cornerRadius = frame.width * normalizedRatio
        }
    }

}
extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
extension UIImageView {

    func addShadowImage(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
extension UIButton {

    func addShadowButton(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

