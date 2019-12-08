//
//  ProfileVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/3/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit
import Kingfisher

fileprivate let headerInitialHeight: CGFloat = AppConstant.screenHeight/3.0

struct UserProfileVM {
    let name: String
    let email: String
    let imgURL: URL?
}

struct ProfileTBCellVM {
    let icon: UIImage?
    let title: String
}

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
