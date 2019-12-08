//
//  AppColor.swift
//  unichat
//
//  Created by Imbaggaarm on 10/13/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

struct AppColor {
    
    private init(){}
    
    static let white = UIColor.white
    static let black = UIColor.black
    static let redOrangeColor = UIColor.init(hexString: "#FF4A57")
    
    static var background: UIColor {
        return UIColor.init(hexString: "#000000")
    }
    
    static let backgroundColor = UIColor.init(hexString: "#1C1E21")
    
    static let btnBackgroundColor = UIColor.init(hexString: "#1C1E21")
    
    static var barTint: UIColor {
        return UIColor.black
    }
    
    static var tint: UIColor {
        return UIColor.black
    }
    
    static var inputBackgroundColor: UIColor {
        return UIColor.init(hexString: "#ECF0F1")
    }
    
    static let themeColor = UIColor.init(hexString: "#007AFF")
    
    static let navTintColor = UIColor.init(hexString: "#007AFF")
    
    static let accountSettingVCCellLblTitleNormalTxtColor = UIColor.init(hexString: "#fff")
    static let accountSettingVCCellLblTitleHighlightedTxtColor = UIColor.init(hexString: "#FF4A57")
    
    static let accountSettingVCCellContentViewBorderColor = UIColor.darkGray//UIColor.init(hexString: "#DADFE4")
    
    static let settingsVCLblEmailTxtFont = UIFont.avenirNext(size: 14, type: .demiBold)
    static let settingVCDescribeTextColor = UIColor.init(white: 0.6, alpha: 1)
    static let settingVCTxtFTextColor = UIColor.init(white: 1, alpha: 1)
    static let settingVCTxtFPlaceHolderColor = UIColor.init(white: 0.75, alpha: 1)
}
