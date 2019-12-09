//
//  UserEndpoint.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/30/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation
import Alamofire

enum UserEndPoint: APIConfiguration {
    case login(email: String, password: String)
    case profile(id: UInt)
    case updateProfile(firstName: String, lastName: String)
    case courses
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .profile:
            return .get
        case .updateProfile:
            return .post
        case .courses:
            return .get
        }
    }
        
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .profile(let id):
            return "/\(id)"
        case .updateProfile:
            return "/update_profile"
        case .courses:
            return "/\(UserProfile.this.id)/courses"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [AppConstant.APIParameterKey.email: email, AppConstant.APIParameterKey.password: password]
        case .updateProfile(let firstName, let lastName):
            return [AppConstant.APIParameterKey.firstName: firstName, AppConstant.APIParameterKey.lastName: lastName]
        case .profile:
            return nil
        case .courses:
            return nil
        }
    }
    
//    func asURLRequest() throws -> URLRequest {
//        let url = try K.ProductionServer.baseURL.asURL()
//
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//
//        // HTTP Method
//        urlRequest.httpMethod = method.rawValue
//
//        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.form_urlencoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//
//        // Parameters
//        if let parameters = parameters {
//            let parameterArray = parameters.map { (key, value) -> String in
//                return "\(key)=\(self.percentEscapeString(string: value as! String))"
//            }
//
//            urlRequest.httpBody = parameterArray.joined(separator: "&").data(using: .utf8)
//        }
//
//        return urlRequest
//    }
}
