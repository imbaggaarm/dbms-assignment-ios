//
//  CommentEndpoint.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation
import Alamofire

enum CommentEndpoint: APIConfiguration {
    case getComments(courseID: UInt, offSet: UInt)
    case createComment(comment: [String: Any])
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getComments:
            return .get
        case .createComment:
            return .post
        }
    }
        
    // MARK: - Path
    var path: String {
        switch self {
        case .getComments(let courseID, let offSet):
            return "/courses/\(courseID)/comments?off_set=\(offSet)"
        case .createComment:
            return "/comments/create"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getComments:
            return nil
        case .createComment(let comment):
            return comment
        }
    }
}
