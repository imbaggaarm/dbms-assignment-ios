//
//  Response.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/31/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation

protocol Response {
    
//    var type: String { get set }
    
    var status: Bool { get set }
    
    var message: String { get set }
}

struct BaseResponse: Response, Codable {
    var status: Bool
    
    var message: String
}

struct LoginResponseData: Codable {
    
    let id: UInt
    
    let email: String
    
    let firstName: String
    
    let lastName: String
    
    let token: String
    
    let imageUrl: String
    
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case token
        case imageUrl = "image_url"
        case location
    }
}

struct LoginResponse: Response, Codable {
    
//    var type: String
    
    var status: Bool
    
    var message: String
    
    let data: UserProfile?
}

struct LogoutResponse: Response, Codable {
    
//    var type: String
    
    var status: Bool
    
    var message: String
}

struct UserProfileResponse: Response, Codable {
    
//    var type: String
    
    var status: Bool
    
    var message: String
    
    let data: UserProfile?
}

struct UserFriendsResponse: Response, Codable {
    
//    var type: String
    
    var status: Bool
    
    var message: String
    
    let data: [UserProfile]?
}

struct CoursesResponse: Response, Codable {
    
    var status: Bool
    
    var message: String
    
    let data: [OverrallCourse]?
}

struct CourseDetailReponse: Response, Codable {
    
    var status: Bool
    
    var message: String
    
    let data: Course?
}

struct CommentsResponse: Response, Codable {
    
    var status: Bool
    
    var message: String
    
    let data: [Comment]?
}

struct CommentResponse: Response, Codable {
    
    var status: Bool
    
    var message: String
    
    let data: MiniComment?
}
