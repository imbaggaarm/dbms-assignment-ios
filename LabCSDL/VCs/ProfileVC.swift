//
//  ProfileVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileVC: ProfileVCLayout {
    
    struct Action {
        static let UPDATE = 0
        static let DELETE = 1
        static let LOGOUT = 2
    }
    
    var profileVM: UserProfileVM?
    
    var vms: [ProfileTBCellVM] = [
        ProfileTBCellVM(icon: AppIcon.edit, title: "Cập nhật thông tin"),
        ProfileTBCellVM(icon: AppIcon.delete, title: "Xoá tài khoản"),
        ProfileTBCellVM(icon: AppIcon.logout, title: "Đăng xuất")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        showData()
    }
    
    
    override func showData() {
        super.showData()
        
        lblName.text = UserProfile.this.lastName + " " + UserProfile.this.firstName
        lblEmail.text = UserProfile.this.email
        imgVProfile.kf.setImage(with: URL.init(string: UserProfile.this.imageUrl), placeholder: AppIcon.userAvtPlaceholder)
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID") as! ProfileTableViewCell
        cell.vm = vms[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case ProfileVC.Action.UPDATE:
            presentUpdateProfileVC()
        case ProfileVC.Action.DELETE:
            confirmDeleteAccount()
        case ProfileVC.Action.LOGOUT:
            logout()
        default:
            break
        }
    }
    
    func confirmDeleteAccount() {
        let alertVC = UIAlertController.init(title: "Xoá tài khoản", message: "Tài khoản của bạn sẽ bị xoá vĩnh viễn", preferredStyle: .alert)
        let yes = UIAlertAction.init(title: "OK", style: .destructive) { (_) in
            self.deleteAccount()
        }
        
        let no = UIAlertAction.init(title: "Huỷ", style: .cancel) { (_) in
            //
        }
        
        alertVC.addAction(yes)
        alertVC.addAction(no)
        present(alertVC, animated: true, completion: nil)
    }
    
    func deleteAccount() {
        APIClient.deleteAccount().execute(onSuccess: { (response) in
            if response.status {
                self.dismissToWelcome()
            } else {
                self.letsAlert(withMessage: response.message)
//                self?.stopRequestAnimation()
            }
        }) { (error) in
            self.letsAlert(withMessage: error.asAFError?.errorDescription ?? "Unexpected error")
        }
    }
    
    func logout() {
        let alertVC = UIAlertController.init(title: "Đăng xuất", message: "Bạn chắc chắn muốn đăng xuất?", preferredStyle: .alert)
        let yes = UIAlertAction.init(title: "Đăng xuất", style: .destructive) { (_) in
            self.dismissToWelcome()
        }
        
        let no = UIAlertAction.init(title: "Huỷ", style: .cancel) { (_) in
            //
        }
        
        alertVC.addAction(yes)
        alertVC.addAction(no)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func dismissToWelcome() {
        UserProfile.this.token = ""
        self.navigationController?.tabBarController?.dismissMySelf()
    }
    
    func presentUpdateProfileVC() {
        let vc = UINavigationController.init(rootViewController: UpdateProfileVC())
        present(vc, animated: true, completion: nil)
    }


}
