//
//  APIConfiguration.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/30/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension APIConfiguration {
    var headers: [(String, String)] {
        return [
            (HTTPHeaderField.acceptType.rawValue, ContentType.json.rawValue),
            (HTTPHeaderField.contentType.rawValue, ContentType.json.rawValue),
            (HTTPHeaderField.authentication.rawValue, "Bearer " + UserProfile.this.token)
        ]
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
    
    func asURLRequest() throws -> URLRequest {
        let urlStr = AppConstant.ProductionServer.baseURL + path
        let urlWithPercent = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: urlWithPercent)!)
        
        print(urlRequest)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        headers.forEach { (field, value) in
            urlRequest.addValue(value, forHTTPHeaderField: field)
        }
        
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
