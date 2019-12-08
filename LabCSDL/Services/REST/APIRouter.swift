//
//  APIRouter.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/30/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case login(email: String, password: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    // MARK - Parameters
    private var parameters: Parameters?
    {
        switch self {
        case .login(let email, let password):
            return [AppConstant.APIParameterKey.email: email, AppConstant.APIParameterKey.password: password]
        }
    }
    
//    private func percentEscapeString(string: String) -> String {
//        var characterSet = CharacterSet.alphanumerics
//        characterSet.insert(charactersIn: "-._* ")
//
//        return string
//          .addingPercentEncoding(withAllowedCharacters: characterSet)!
//          .replacingOccurrences(of: " ", with: "+")
//          .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
//    }
    
    // MARK - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try AppConstant.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

