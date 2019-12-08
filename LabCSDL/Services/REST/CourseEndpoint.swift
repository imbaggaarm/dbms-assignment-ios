//
//  CourseEndpoint.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation
import Alamofire

enum CourseEndpoint: APIConfiguration {
    case getCourses(offSet: UInt)
    case courseDetail(id: UInt)
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getCourses:
            return .get
        case .courseDetail:
            return .get
        }
    }
        
    // MARK: - Path
    var path: String {
        switch self {
        case .getCourses(let offSet):
            return "/courses/list?off_set=\(offSet)"
        case .courseDetail(let id):
            return "/courses/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getCourses:
            return nil
        case .courseDetail:
            return nil
        }
    }
}
