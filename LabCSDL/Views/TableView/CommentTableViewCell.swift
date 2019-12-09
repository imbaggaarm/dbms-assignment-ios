//
//  CommentTableViewCell.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CommentTableViewCell: IMBBaseTableViewCell {
    
    var vm: CommentVM? {
        didSet {
            showData()
        }
    }
    
    let imgV: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = AppColor.black
        temp.layer.borderColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        temp.layer.borderWidth = 0.5
        return temp
    }()
    
    let lblTime: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.gray
        temp.text = "1 giờ trước"
        temp.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return temp
    }()
    
    let vContent: UIView = {
        let temp = UIView()
        temp.layer.cornerRadius = 12
        temp.backgroundColor = UIColor.init(hexString: "#ECF0F1")
        return temp
    }()
    
    let lblName: UILabel = {
        let temp = UILabel()
        temp.text = "Tài Dương"
        temp.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return temp
    }()
    
    let lblText: UILabel = {
        let temp = UILabel()
        temp.text = "Bài giảng khá hay"
        temp.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return temp
    }()
    
    override func setUpLayout() {
        super.setUpLayout()
        
        contentView.addSubviews(subviews: imgV, vContent, lblTime)
        let maxWidth = widthOfScreen - 10 - 10 - 10
        contentView.addConstraintsWith(format: "H:|-10-[v0]-10-[v1(<=\(maxWidth))]", views: imgV, vContent)
    
        
        contentView.addConstraintsWith(format: "V:|-10-[v0]", views: imgV)
        vContent.topAnchor(equalTo: imgV.topAnchor, constant: 0)
        contentView.addConstraintsWith(format: "V:[v0]-5-[v1(15)]-5-|", views: vContent, lblTime)
        
        imgV.makeCircle(corner: 20)
        
        lblTime.leftAnchor(equalTo: vContent.leftAnchor, constant: 5)
        
        vContent.addSubviews(subviews: lblName, lblText)
        vContent.addSameConstraintsWith(format: "H:|-8-[v0]-8-|", for: lblName, lblText)
        vContent.addConstraintsWith(format: "V:|-4-[v0(15)]-4-[v1]-4-|", views: lblName, lblText)
    }
    
    override func showData() {
        lblText.text = vm?.content
        lblName.text = vm?.displayName
        lblTime.text = vm?.time
        imgV.kf.setImage(with: vm?.imageURL, placeholder: AppIcon.userAvtPlaceholder)
        
    }
}
