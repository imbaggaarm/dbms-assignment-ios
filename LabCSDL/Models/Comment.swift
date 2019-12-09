//
//  Comment.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class MiniComment: Codable {
    let id: UInt = 0
    let courseID: UInt
    let studentID: UInt
    let content: String
    let commentTime: String
}

extension MiniComment {
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case commentTime = "cmmt_time"
        case courseID = "course_id"
        case studentID = "student_id"
    }
}


class Comment: Codable {
    var id: UInt = 0
    let courseID: UInt
    let studentID: UInt
    let content: String
    let commentTime: String
    let stdFirstName: String
    let stdLastName: String
    let imageUrl: String
    
    init(courseID: UInt, studentID: UInt, stdFN: String, stdLN: String, img_url: String, content: String, time: String) {
        self.courseID = courseID
        self.studentID = studentID
        self.content = content
        self.commentTime = time
        self.stdFirstName = stdFN
        self.stdLastName = stdLN
        self.imageUrl = img_url
    }
    
    func createNewCmtDict() -> [String: Any] {
        return [
            CodingKeys.content.rawValue: content,
            CodingKeys.studentID.rawValue: studentID,
            CodingKeys.courseID.rawValue: courseID,
            CodingKeys.commentTime.rawValue: commentTime
        ]
    }
}

extension Comment {
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case commentTime = "cmmt_time"
        case courseID = "course_id"
        case studentID = "student_id"
        case stdLastName = "std_last_name"
        case stdFirstName = "std_first_name"
        case imageUrl = "std_image_url"
    }
}

let dateFormatter: DateFormatter = {
    let temp = DateFormatter()
    temp.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return temp
}()

fileprivate func calculateHeight(content: String) -> CGFloat {
    let attributedText = NSAttributedString.init(string: content, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
    
    let width = widthOfScreen - 10 - 10 - 10 - 40 - 16
    let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
    let rect = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).integral
    
    return rect.size.height >= 20 ? rect.size.height : 20
}

struct CommentVM {
    
    var imageURL: URL?
    
    var displayName: String
    
    var content: String
    
    var time: String
    
    var comment: Comment
    
    var heightOfCell: CGFloat
    
    init(cmt: Comment) {
        comment = cmt
        imageURL = URL.init(string: cmt.imageUrl)
        displayName = cmt.stdLastName + " " + cmt.stdFirstName
        content = cmt.content
        let date = dateFormatter.date(from: cmt.commentTime) ?? Date()
        time = IMBPrettyDateLabel.handleGetFormatDateOfPost(datePost: date)
        
        heightOfCell = 10 + 4 + 15 + 4 + calculateHeight(content: content) + 4 + 5 + 15 + 5
    }
    
}
