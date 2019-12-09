//
//  Course.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

struct Course: Codable {
    let id: UInt
    let name: String
    let imageURL: String
    let commitment: String
    let description: String
    let specializationID: UInt
    let minGrade: Float
    let coursePrice: Float
    let active: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case commitment
        case description
        case specializationID = "specialization_id"
        case minGrade = "min_grade"
        case coursePrice = "course_price"
        case active = "active"
    }
}

struct OverrallCourse: Codable {
    let id: UInt
    let imgURL: String
    let name: String
    let institutionName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imgURL = "image_url"
        case name
        case institutionName = "institution_name"
    }
}

struct CourseVM {
    var course: Course
    var name: String
    var institutionName: String
    var institutionImageURL: URL?
    var description: String
    var price: String
    
    init(course: Course, institutionName: String, institutionImageURL: URL?) {
        self.course = course
        self.name = course.name
        self.institutionName = institutionName
        self.institutionImageURL = institutionImageURL
        self.description = course.description
        self.price = "\(course.coursePrice)$"
    }
}
