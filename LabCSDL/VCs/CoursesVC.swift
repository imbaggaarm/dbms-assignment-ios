//
//  CoursesVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

struct CourseTBCVM {
    let title: String
    let institutionName: String
    let imgURL: URL?
    
    init(title: String, institutionName: String, imgURL: URL?) {
        self.title = title
        self.institutionName = institutionName
        self.imgURL = imgURL
    }
    
    init(course: OverrallCourse) {
        self.title = course.name
        self.institutionName = course.institutionName
        self.imgURL = URL.init(string: course.imgURL)
    }
}

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
    }
}

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

class CoursesVC: CoursesVCLayout {
    
    var vms = [CourseTBCVM]()
//        CourseTBCVM(title: "Học lập trình iOS", institutionName: "HCMUT", imgURL: nil),
//        CourseTBCVM(title: "Kĩ năng chuyên nghiệp cho kĩ sư", institutionName: "HCMUT", imgURL: nil),
//        CourseTBCVM(title: "Nguyên lý ngôn ngữ lập trình", institutionName: "HCMUT", imgURL: nil),
//        CourseTBCVM(title: "Nhập môn lập trình", institutionName: "HCMUT", imgURL: nil),
//        CourseTBCVM(title: "Phân tích và thiết kế hệ thống", institutionName: "HCMUT", imgURL: nil),
//        CourseTBCVM(title: "Nhập môn kỹ thuật", institutionName: "HCMUT", imgURL: nil),
//        CourseTBCVM(title: "Quản trị kinh doanh cho kĩ sư", institutionName: "HCMUT", imgURL: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    var offSet: UInt = 0
    var isOutOfData: Bool = false
    func loadData() {
        APIClient.getCourses(offSet: offSet).execute(onSuccess: { (response) in
            if response.status {
                self.vms = response.data!.map { CourseTBCVM(course: $0)}
                self.tableView.reloadData()
                self.offSet = response.data!.last!.id
                if response.data!.count < 20 {
                    self.isOutOfData = true
                }
            } else {
                self.letsAlert(withMessage: response.message)
            }
            
        }, onFailure: { err in
            self.letsAlert(withMessage: err.asAFError?.errorDescription ?? "Unexpected Error")
        })
    }

}

extension CoursesVC: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vm = vms[indexPath.row]
        let vc = CourseDetailVC()
        let nvc = UINavigationController.init(rootViewController: vc)
        nvc.modalPresentationStyle = .overCurrentContext
        navigationController?.tabBarController?.present(nvc, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == vms.count - 4 && !isOutOfData {
            loadData()
        }
    }
}
