//
//  MainVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.background
        tabBar.tintColor = AppColor.tint
    
        let profileVC = ProfileVC()
        let profileNVC = createNVC(vc: profileVC, title: "Cá nhân", backgroundColor: AppColor.background, icon: AppIcon.tabbarProfile)
        
        let myCoursesVC = MyCoursesVC()
        let myCoursesNVC = createNVC(vc: myCoursesVC, title: "Khoá học của tôi", backgroundColor: AppColor.background, icon: AppIcon.tabbarMyCourses)
        
        let coursesVC = CoursesVC()
        let coursesNVC = createNVC(vc: coursesVC, title: "Khoá học", backgroundColor: AppColor.background, icon: AppIcon.tabbarCourses)
        
        viewControllers = [profileNVC, myCoursesNVC, coursesNVC]
        
        selectedIndex = 0
        
        setNoTitle()
    }
}
