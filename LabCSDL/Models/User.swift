//
//  User.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/28/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation

enum P2POnlineState: Int, Codable {
    case offline = 0
    case online = 1
    case doNotDisturb = 2
    case idle = 3
}

enum WSOnlineState: Int, Codable {
    case offline = 0
    case online = 1
    case doNotDisturb = 2
}

var myFriends = [UserProfile]()

struct UserAccount: Codable {
    let email: String
    let password: String
}

class UserProfile: Codable {
    static let this: UserProfile = UserProfile(id: 0, email: "", firstName: "", lastName: "", location: "", displayName: "", imageUrl: "", token: "")
    
    var id: UInt
    var email: String
    var imageUrl: String
    var firstName: String
    var lastName: String
    var location: String
    var displayName: String = ""
    var token: String = ""
        
    init(id: UInt, email: String, firstName: String, lastName: String, location: String, displayName: String, imageUrl: String, token: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.location = location
        self.displayName = displayName
        self.imageUrl = imageUrl
        self.token = token
    }
    
    func copy(from u: UserProfile) {
        self.id = u.id
        self.email = u.email
        self.firstName = u.firstName
        self.lastName = u.lastName
        self.location = u.location
        self.displayName = u.displayName
        self.imageUrl = u.imageUrl
        self.token = u.token
    }
}

extension UserProfile {
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case imageUrl = "image_url"
        case firstName = "first_name"
        case lastName = "last_name"
        case location
        case token
    }
}
