//
//  CoursesVCLayout.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CoursesVCLayout: BaseViewControllerLayout {
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.backgroundColor = AppColor.white
        temp.register(CourseTableViewCell.self, forCellReuseIdentifier: "CELL_ID")
        return temp
    }()
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.addSubview(tableView)
        tableView.makeFullWithSuperView()
    }
}

