//
//  ProfileTableViewCell.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class ProfileTableViewCell: IMBBaseTableViewCell {
    
    var vm: ProfileTBCellVM? {
        didSet {
            showData()
        }
    }
    
    let imgVIcon: UIImageView = {
        let temp = UIImageView()
        temp.tintColor = AppColor.black
        return temp
    }()
    
    let lblTitle: UILabel = {
        let temp = UILabel()
        temp.textColor = AppColor.black
        temp.font = UIFont.systemFont(ofSize: 14)
        return temp
    }()
    
    override func setUpLayout() {
        super.setUpLayout()
        
        contentView.backgroundColor = AppColor.white
        contentView.addSubviews(subviews: imgVIcon, lblTitle)
        contentView.addConstraintsWith(format: "H:|-10-[v0]-10-[v1]-10-|", views: imgVIcon, lblTitle)
        contentView.addSameConstraintsWith(format: "V:|-15-[v0]-15-|", for: imgVIcon)
        
        lblTitle.centerYAnchor(with: contentView)
        
        imgVIcon.makeSquare(size: 20)
    }
    
    override func showData() {
        super.showData()
        
        imgVIcon.image = vm!.icon
        lblTitle.text = vm!.title
        
    }
}
