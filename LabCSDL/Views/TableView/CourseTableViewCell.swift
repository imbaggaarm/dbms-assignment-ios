//
//  CourseTBVCell.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CourseTableViewCell: IMBBaseTableViewCell {
    
    var vm: CourseTBCVM? {
        didSet {
            showData()
        }
    }
    
    let imgV: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = AppColor.black
        return temp
    }()
    
    let lblTitle: UILabel = {
        let temp = UILabel()
        temp.text = "Học lập trình iOS với Objective C"
        temp.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        temp.numberOfLines = 0
        return temp
    }()
    
    let lblInstitution: UILabel = {
        let temp = UILabel()
        temp.text = "Đại học Bách Khoa TP.HCM"
        temp.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return temp
    }()
    
    override func setUpLayout() {
        super.setUpLayout()
        
        let contentViewLbls = UIView()
        contentView.addSubviews(subviews: imgV, contentViewLbls)
        contentView.addConstraintsWith(format: "H:|-10-[v0]-10-[v1]-10-|", views: imgV, contentViewLbls)
        contentView.addConstraintsWith(format: "V:|-10-[v0]-10-|", views: imgV)
        contentViewLbls.centerYAnchor(with: contentView)
        
        
        contentViewLbls.addSubviews(subviews: lblTitle, lblInstitution)
        contentViewLbls.addConstraintsWith(format: "V:|[v0][v1(<=40)]|", views: lblTitle, lblInstitution)
        contentViewLbls.addSameConstraintsWith(format: "H:|[v0]|", for: lblTitle, lblInstitution)
        
        imgV.makeSquare(size: 80)
    }
    
    override func showData() {
        
        lblTitle.text = vm?.title
        lblInstitution.text = vm?.institutionName
        imgV.kf.setImage(with: vm?.imgURL, placeholder: AppIcon.imagePlaceHolder)
    }
}
