//
//  CourseDetailHeaderView.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CourseDetailHeaderView: UIView {
    
    let lblTitle: UILabel = {
        let temp = UILabel()
        temp.text = "Học lập trình iOS với Objective C"
        temp.textColor = AppColor.white
        temp.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return temp
    }()
    
    let lblInstitution: UILabel = {
        let temp = UILabel()
        temp.text = "HCMUT University"
        temp.textColor = AppColor.white
        temp.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return temp
    }()
    
    let imgV: UIImageView = {
        let temp = UIImageView()
        temp.clipsToBounds = true
        temp.backgroundColor = AppColor.white
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.themeColor
        
        addSubviews(subviews: lblTitle, lblInstitution, imgV)
        
        addConstraintsWith(format: "V:[v0]-5-[v1]-40-|", views: lblTitle, lblInstitution)
        lblTitle.topAnchor(equalTo: self.layoutMarginsGuide.topAnchor)
        imgV.centerYAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imgV.makeCircle(corner: 15)
        
        addSameConstraintsWith(format: "H:|-10-[v0]-10-|", for: lblTitle, lblInstitution)
        addConstraintsWith(format: "H:|-10-[v0]", views: imgV)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
