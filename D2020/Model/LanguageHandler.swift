//
//  LanguageHandler.swift
//  D2020
//
//  Created by Mohamed Eltaweel on 12/07/2021.
//

import Foundation
import Localize_Swift

public struct AppLanguageHandler{
    func setAppLang(with lang: String){
        Localize.setCurrentLanguage("\(lang)")
        if lang == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}
