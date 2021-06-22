//
//  Localization.swift
//  Fit&Rock
//
//  Created by Macbook on 11/21/19.
//  Copyright © 2019 Arabia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

extension UILabel {
    @IBInspectable
    var localizedContent: String {
        get {
            return text!
        }
        set {
            text = newValue.localized()
        }
    }
}

extension UIButton {
    @IBInspectable
    var localizedContent: String {
        get {
            return titleLabel?.text ?? ""
        }
        set {
            setTitle(newValue.localized(), for: .normal)
        }
    }
}

extension UITextField {
    @IBInspectable
    var localizedPlaceholder: String {
        get {
            return placeholder ?? ""
        }
        set {
            placeholder = newValue.localized()
        }
    }
    @IBInspectable
    var localizedContent: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue.localized()
        }
    }
}

extension UITextView {
    @IBInspectable
    var localizedContent: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue.localized()
        }
    }
}

extension UISearchBar{
    var localizedPlaceholder: String {
        get {
            return placeholder ?? ""
        }
        set {
            placeholder = newValue.localized()
        }
    }
}

extension UITabBarItem {
    @IBInspectable
    var localizedContent: String {
        get {
            return title ?? ""
        }
        set {
            title = newValue.localized()
        }
    }
}
