//
//  CourseDetailVCLayout.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CourseDetailVCLayout: BaseViewControllerLayout {
    
    let vHeader: CourseDetailHeaderView = {
        let temp = CourseDetailHeaderView()
        return temp
    }()
    
    let segControl: UISegmentedControl = {
        let temp = UISegmentedControl(items: ["Home", "Lesson", "Forum", "Grades", "Comment"])
        temp.selectedSegmentIndex = 0
        temp.backgroundColor = AppColor.themeColor
        return temp
    }()
    
    let vInfo: CourseInfoView = {
        let temp = CourseInfoView()
        return temp
    }()
    
    let vComments: CourseCommentsView = {
        let temp = CourseCommentsView()
        return temp
    }()
    
    lazy var inputMessageBar: IMBInputMessageBar = {
        let temp = IMBInputMessageBar()
        
        return temp
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    var vCurrentShowing: UIView!
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.backgroundColor = AppColor.black
        
        view.addSubviews(subviews: segControl, vHeader, vComments, vInfo)
        view.addConstraintsWith(format: "V:[v0]-20-[v1(30)]", views: vHeader, segControl)
        vHeader.topAnchor(equalTo: view.topAnchor)
        view.addSameConstraintsWith(format: "H:|[v0]|", for: vHeader)
        view.addConstraintsWith(format: "H:|-10-[v0]-10-|", views: segControl)
        
        view.addConstraintsWith(format: "V:[v0]-10-[v1]|", views: segControl, vInfo)
        vInfo.makeFullWidthWithSuperView()
        
        view.addConstraintsWith(format: "V:[v0]-10-[v1]|", views: segControl, vComments)
        vComments.makeFullWidthWithSuperView()
        
        vCurrentShowing = vInfo
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        
        let dismissItem = UIBarButtonItem.init(image: AppIcon.dismissVC, style: .done, target: self, action: #selector(dismissMySelf))
        navigationItem.leftBarButtonItem = dismissItem
        navigationController?.navigationBar.barTintColor = AppColor.themeColor
        navigationController?.navigationBar.tintColor = AppColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
    }

}
