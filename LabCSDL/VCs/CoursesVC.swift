//
//  CoursesVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CoursesVC: CoursesVCLayout {
    
    var vms = [CourseTBCVM]()
    
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
                self.vms.append(contentsOf: response.data!.map { CourseTBCVM(course: $0)})
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
        let vm = vms[indexPath.row]
        let vc = CourseDetailVC()
        vc.overralCourseVM = vm
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
