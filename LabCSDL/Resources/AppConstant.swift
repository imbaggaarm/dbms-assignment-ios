//
//  AppConstant.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/4/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

struct AppConstant {
    
    private init() {}
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static let myScreenType = UIDevice.current.screenType
    
    static let butBorderWidth: CGFloat = 1.5
    
    static let heightOfLoginButton: CGFloat = 40
    
    struct ProductionServer {
        static let baseURL = "http://localhost:8000/api/v1"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let token = "token"
        static let displayName = "display_name"
        static let username = "username"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let offSet = "off_set"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case form_urlencoded = "application/x-www-form-urlencoded"
}
