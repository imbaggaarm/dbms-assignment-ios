//
//  AppIcon.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

struct AppIcon {
    
    private init(){}
    
    static let appIcon = UIImage.init(named: "no image")
    
    static let tabbarProfile = UIImage.init(named: "profile_icon")
    
    static let tabbarMyCourses = UIImage.init(named: "my_courses")
    
    static let tabbarCourses = UIImage.init(named: "courses")
    
    static let delete = UIImage.init(named: "delete")
    static let logout = UIImage.init(named: "logout")
    static let edit = UIImage.init(named: "edit")
    
    static let attachmentIcon = UIImage.init(named: "icons8-attach")
    static let scaleDownTxtVInputMessage = UIImage.init(named: "scaleDownTxtVInputMessageIcon")
    static let fastEmojiTest = UIImage.init(named: "fastEmojiTest")
    static let sendMessage = UIImage.init(named: "send_message_icon")?.withRenderingMode(.alwaysTemplate)
    static let emojiTest = UIImage.init(named: "icons8-happy")?.withRenderingMode(.alwaysTemplate)
    static let fillEmoji = UIImage.init(named: "icons8-happy_filled")?.withRenderingMode(.alwaysTemplate)
    
    static let dismissVC = UIImage.init(named: "dismissVC")
    
    static let userAvtPlaceholder = UIImage.init(named: "placeholder-user-photo")
    static let imagePlaceHolder = UIImage.init(named: "imagePlaceHolder")
    static let editProfile = UIImage.init(named: "edit_profile")
}
