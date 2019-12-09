//
//  CourseTBCVM.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation

struct CourseTBCVM {
    var id: UInt = 0
    let title: String
    let institutionName: String
    let imgURL: URL?
    
    init(title: String, institutionName: String, imgURL: URL?) {
        self.title = title
        self.institutionName = institutionName
        self.imgURL = imgURL
    }
    
    init(course: OverrallCourse) {
        self.id = course.id
        self.title = course.name
        self.institutionName = course.institutionName
        self.imgURL = URL.init(string: course.imgURL)
    }
}
