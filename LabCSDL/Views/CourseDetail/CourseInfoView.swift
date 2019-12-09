//
//  CourseInfoView.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CourseInfoView: UIView {
    
    let lblTitle: UILabel = {
        let temp = UILabel()
        temp.textColor = AppColor.black
        temp.text = "Course Introduction"
        temp.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return temp
    }()
    
    let txtVDescription: UITextView = {
        let temp = UITextView()
        temp.textColor = AppColor.black
        temp.isEditable = false
        temp.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce feugiat tortor sed sodales faucibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque rutrum laoreet elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam mauris justo, dapibus vitae feugiat ultrices, imperdiet non urna. Quisque felis lacus, mattis sed volutpat eu, pulvinar id metus."
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.white
        
        addSubviews(subviews: lblTitle, txtVDescription)
        addConstraintsWith(format: "V:|-[v0][v1]-|", views: lblTitle, txtVDescription)
        addConstraintsWith(format: "H:|-8-[v0]-8-|", views: lblTitle)
        addConstraintsWith(format: "H:|-5-[v0]-5-|", views: txtVDescription)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
