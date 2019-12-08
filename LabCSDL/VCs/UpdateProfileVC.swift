//
//  UpdateProfileVC.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 11/1/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class UpdateProfileVC: BaseViewControllerLayout {
    
    let avtImageView: UIImageView = {
        let temp = UIImageView()
        temp.clipsToBounds = true
        temp.layer.borderColor = AppColor.backgroundColor.cgColor
        temp.layer.borderWidth = 6
        temp.backgroundColor = .darkGray
        temp.image = AppIcon.userAvtPlaceholder
        return temp
    }()
    
    let coverImageView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .darkGray
        temp.contentMode = .scaleAspectFill
        temp.clipsToBounds = true
        temp.image = AppIcon.imagePlaceHolder
        return temp
    }()
    
    let txtFirstName: UITextField = {
        let temp = UITextField()
        temp.font = UIFont.boldSystemFont(ofSize: 23)
        temp.textColor = .white
        temp.placeholder = "Tên và tên lót"
        temp.textAlignment = .center
        return temp
    }()
    
    let txtLastName: UITextField = {
        let temp = UITextField()
        temp.font = UIFont.boldSystemFont(ofSize: 23)
        temp.textColor = .white
        temp.placeholder = "Họ"
        temp.textAlignment = .center
        return temp
    }()
        
    lazy var btnUpdate: ActivityIndicatorButton = {
        [unowned self ] in
        let temp = ActivityIndicatorButton()
        temp.backgroundColor = .darkGray
        temp.setTitle("Cập nhật", for: .normal)
        temp.setTitleColor(.white, for: .normal)
        //temp.titleLabel?.font = AppFont.logInButtonTitleFont
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.addTarget(self, action: #selector(onBtnUpdateTapped), for: .touchUpInside)
        return temp
    }()
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Cập nhật thông tin"
        
        
        let leftItem = UIBarButtonItem.init(image: AppIcon.dismissVC, style: .done, target: self, action: #selector(dismissMySelf))
        
        navigationItem.leftBarButtonItem = leftItem
        
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.backgroundColor = AppColor.backgroundColor
        
        view.addSubviews(subviews: coverImageView, avtImageView, txtFirstName, txtLastName, btnUpdate)
        view.addConstraintsWith(format: "V:[v0]-15-[v1]", views: avtImageView, txtFirstName)
        
        txtLastName.translatesAutoresizingMaskIntoConstraints = false
        
        txtLastName.topAnchor(equalTo: txtFirstName.topAnchor)
        
        btnUpdate.translatesAutoresizingMaskIntoConstraints = false
        btnUpdate.bottomAnchor(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        btnUpdate.width(constant: widthOfScreen/2)
        btnUpdate.height(constant: AppConstant.heightOfLoginButton)
        btnUpdate.layer.cornerRadius = AppConstant.heightOfLoginButton/2
        btnUpdate.centerXAnchor(with: view)
        btnUpdate.setIndicatorViewFrame(width: widthOfScreen/2, height: AppConstant.heightOfLoginButton)
        
        view.addConstraintsWith(format: "H:|-16-[v0]-16-|", views: coverImageView)
        view.addConstraintsWith(format: "H:|-8-[v0(v1)]-[v1]-8-|", views: txtLastName, txtFirstName)
        
        coverImageView.topAnchor(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16)
        coverImageView.roundCorners(corners: [.topLeft, .topRight], radius: 12, bounds: CGRect.init(x: 0, y: 0, width: widthOfScreen - 32, height: 1000))
        coverImageView.height(constant: (widthOfScreen - 32)*1/3 + widthOfScreen/4 - 16)
        
        avtImageView.topAnchor(equalTo: coverImageView.bottomAnchor, constant: -widthOfScreen/4)
        avtImageView.centerXAnchor(with: view)
        avtImageView.makeCircle(corner: widthOfScreen/4)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
        
        txtFirstName.addTarget(self, action: #selector(checkEnableBtnUpdate), for: .editingChanged)
        txtLastName.addTarget(self, action: #selector(checkEnableBtnUpdate), for: .editingChanged)
    }
    
    override func showData() {
        super.showData()
        txtFirstName.text = UserProfile.this.firstName
        txtLastName.text = UserProfile.this.lastName
        coverImageView.kf.setImage(with: URL.init(string: UserProfile.this.imageUrl), placeholder: AppIcon.imagePlaceHolder)
        avtImageView.kf.setImage(with: URL.init(string: UserProfile.this.imageUrl), placeholder: AppIcon.userAvtPlaceholder)
    }

    func startRequestAnimation() {
        btnUpdate.startAnimating()
        navigationController?.view.isUserInteractionEnabled = false
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }

    func stopRequestAnimation() {
        btnUpdate.stopAnimating()
        navigationController?.view.isUserInteractionEnabled = true
    }
    
    @objc func checkEnableBtnUpdate() {
        let isTxtDisplayNameEmpty = (txtFirstName.text?.isEmpty)!

        let isTxtUsernameEmpty = (txtLastName.text?.isEmpty)!
        
        changeBtnUpdateState(isEnabled: !isTxtDisplayNameEmpty && !isTxtUsernameEmpty)
    }
    
    func changeBtnUpdateState(isEnabled: Bool) {
        btnUpdate.isEnabled = isEnabled
        btnUpdate.backgroundColor = isEnabled ? AppColor.themeColor : .darkGray
    }

    @objc func onBtnUpdateTapped() {
        view.endEditing(true)
        startRequestAnimation()
        //call update process
        APIClient.updateUserProfile(firstName: txtFirstName.text!, lastName: txtLastName.text!)
            .execute(onSuccess: {[weak self] (response) in
                if response.status {
                    UserProfile.this.copy(from: response.data!)
                    self?.dismissToPresenting()
                } else {
                    self?.letsAlert(withMessage: response.message)
                    self?.stopRequestAnimation()
                }
            }) {[weak self] (error) in
                self?.letsAlert(withMessage: error.asAFError?.errorDescription ?? "Unexpected error")
                self?.stopRequestAnimation()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func dismissToPresenting() {
        if let welcomeVC = presentingViewController as? WelcomeVC {
            welcomeVC.shouldPresentMainVC = true
            dismiss(animated: false) {
                welcomeVC.presentMainVC()
            }
            return
        } else {
            if let nav = presentingViewController as? UITabBarController {
                if let profileNVC = nav.selectedViewController as? UINavigationController, let profileVC = profileNVC.topViewController as? ProfileVC {
                    profileVC.showData()
                }
            }
            dismissMySelf()
        }
    }

}
