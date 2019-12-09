//
//  ProfileVCLayout.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

fileprivate let headerInitialHeight: CGFloat = AppConstant.screenHeight/3.0

class ProfileVCLayout: BaseViewControllerLayout {
    
    let lblName: UILabel = {
        let temp = UILabel()
        temp.textColor = .white
        temp.text = "Dương Văn Tài"
        temp.textAlignment = .center
        temp.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return temp
    }()
    
    let lblEmail: UILabel = {
        let temp = UILabel()
        temp.text = "contact@hcmut.edu.vn"
        temp.textColor = .white
        temp.textAlignment = .center
        temp.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return temp
    }()
    
    let imgVProfile: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFill
        temp.backgroundColor = AppColor.black
        return temp
    }()
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.backgroundColor = UIColor.white
        temp.register(ProfileTableViewCell.self, forCellReuseIdentifier: "CELL_ID")
        return temp
    }()
    
    let vHeader: UIView = {
        let temp = UIView()
        temp.backgroundColor = AppColor.themeColor
        return temp
    }()
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.addSubviews(subviews: tableView, vHeader)
        
        // Vertical
        view.addConstraintsWith(format: "V:|[v0]|", views: tableView)
        view.addConstraintsWith(format: "V:|[v0]", views: vHeader)
        
        vHeader.height(constant: headerInitialHeight)
        
        // Horizontal
        view.addSameConstraintsWith(format: "H:|[v0]|", for: vHeader, tableView)
        
        vHeader.addSubviews(subviews: imgVProfile, lblName, lblEmail)
        vHeader.addConstraintsWith(format: "V:[v0]-10-[v1(20)][v2(20)]", views: imgVProfile, lblName, lblEmail)
        imgVProfile.makeCircle(corner: 50)
        imgVProfile.topAnchor(equalTo: vHeader.layoutMarginsGuide.topAnchor, constant: 12)
        imgVProfile.centerXAnchor(with: vHeader)
        vHeader.addSameConstraintsWith(format: "H:|-20-[v0]-20-|", for: lblName, lblEmail)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset.top = headerInitialHeight - view.layoutMargins.top
    }
}

