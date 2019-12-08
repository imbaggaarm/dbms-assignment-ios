//
//  MyCoursesVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class MyCoursesVCLayout: BaseViewControllerLayout {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class MyCoursesVC: MyCoursesVCLayout {
    
    var vms = [
        CourseTBCVM(title: "Học lập trình iOS", institutionName: "HCMUT", imgURL: nil),
        CourseTBCVM(title: "Kĩ năng chuyên nghiệp cho kĩ sư", institutionName: "HCMUT", imgURL: nil),
        CourseTBCVM(title: "Nguyên lý ngôn ngữ lập trình", institutionName: "HCMUT", imgURL: nil),
        CourseTBCVM(title: "Nhập môn lập trình", institutionName: "HCMUT", imgURL: nil),
        CourseTBCVM(title: "Phân tích và thiết kế hệ thống", institutionName: "HCMUT", imgURL: nil),
        CourseTBCVM(title: "Nhập môn kỹ thuật", institutionName: "HCMUT", imgURL: nil),
        CourseTBCVM(title: "Quản trị kinh doanh cho kĩ sư", institutionName: "HCMUT", imgURL: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension MyCoursesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID") as! CourseTableViewCell
        cell.vm = vms[indexPath.row]
        return cell
    }
}
