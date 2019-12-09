//
//  CourseDetailVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/8/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CourseDetailVC: CourseDetailVCLayout {
    
    let INDEX_HOME = 0
    let INDEX_LESSON = 1
    let INDEX_FORUM = 2
    let INDEX_GRADES = 3
    let INDEX_COMMENT = 4
    
    var selectedIndex = 0
    
    override var inputAccessoryView: UIView? {
        get {
            if selectedIndex == INDEX_COMMENT {
                return inputMessageBar
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vComments.tableView.contentInset.bottom = inputMessageBar.heightOfMessageBar
        segControl.addTarget(self, action: #selector(onSegControlSelected), for: .valueChanged)

        vComments.delegate = self
        
        inputMessageBar.delegate = self
    }
    
    var overralCourseVM: CourseTBCVM? {
        didSet {
            if overralCourseVM != nil {
                loadData()
            }
        }
    }
    
    var courseVM: CourseVM!
    
    var comments = [Comment]()
    var offSet: UInt = 0
    var isOutOfComments = false
    
    func loadData() {
        APIClient.courseDetail(id: overralCourseVM!.id).execute(onSuccess: { (response) in
            if response.status {
                self.courseVM = CourseVM.init(course: response.data!, institutionName: self.overralCourseVM!.institutionName, institutionImageURL: self.overralCourseVM?.imgURL)
                self.showData()
            } else {
                self.letsAlert(withMessage: response.message)
            }
        }) { (error) in
            self.letsAlert(withMessage: error.asAFError?.errorDescription ?? "Unexpected Error")
        }
        
        loadComments()
    }
    
    func loadComments() {
        APIClient.getComments(courseID: overralCourseVM!.id, offSet: offSet).execute(onSuccess: { (response) in
            if response.status {
                if let cmts = response.data {
                    if self.offSet == 0 {
                        self.comments = cmts
                    } else {
                        self.comments.append(contentsOf: cmts)
                    }
                    
                    self.offSet = cmts.last?.id ?? self.offSet
                    if cmts.count < 20 {
                        self.isOutOfComments = true
                    }
                } else {
                    self.isOutOfComments = true
                }
                self.vComments.reloadData(commentVMs: self.comments.map { CommentVM.init(cmt: $0) }, isOutOfData: self.isOutOfComments)
            } else {
                self.letsAlert(withMessage: response.message)
            }
        }) { (error) in
            self.letsAlert(withMessage: error.asAFError?.errorDescription ?? "Unexpected Error")
        }

    }
    
    override func showData() {
        super.showData()
        
        vHeader.imgV.kf.setImage(with: courseVM.institutionImageURL, placeholder: AppIcon.imagePlaceHolder)
        vHeader.lblInstitution.text = courseVM.institutionName
        vHeader.lblTitle.text = courseVM.name
        
        vInfo.txtVDescription.text = courseVM.description
    }
    
    @objc func onSegControlSelected() {
        if selectedIndex == segControl.selectedSegmentIndex { return }
        selectedIndex = segControl.selectedSegmentIndex
        
        switch segControl.selectedSegmentIndex {
        case INDEX_HOME:
            showView(v: vInfo)
        case INDEX_COMMENT:
            showView(v: vComments)
            
        default:
            break
        }
    }
    
    func showView(v: UIView) {
        view.bringSubviewToFront(v)
        view.endEditing(true)
        reloadInputViews()
    }
}

extension CourseDetailVC: CourseCommentsViewDelegate {
    func loadMoreData(commentsView: CourseCommentsView) {
        loadComments()
    }
    
    func presentAction(commentsView: CourseCommentsView, cmtIndex: Int) {
        //show options
        let actionVC = UIAlertController.init(title: "Hành động", message: "Chọn hành động dưới đây", preferredStyle: .actionSheet)
        
        let delete = UIAlertAction.init(title: "Xoá", style: .destructive) { (action) in
            //
        }
        
        let update = UIAlertAction.init(title: "Sửa", style: .default) { (action) in
            //
        }
        
        let cancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            //
        }
        
        actionVC.addAction(update)
        actionVC.addAction(delete)
        actionVC.addAction(cancel)
        
        present(actionVC, animated: true, completion: nil)
    }
}

extension CourseDetailVC: InputMessageBarDelegate {
    func inputMessageBarDidTapButtonEmoji() {
    }
    
    func sendComment(cmt: Comment) {
        print(cmt.createNewCmtDict())
        APIClient.createComment(cmt: cmt.createNewCmtDict()).execute(onSuccess: { (response) in
            if response.status {
                cmt.id = response.data!.id
                self.comments.append(cmt)
                self.offSet = response.data!.id
                self.vComments.reloadData(commentVMs: self.comments.map { CommentVM.init(cmt: $0) }, isOutOfData: self.isOutOfComments)
            } else {
                self.letsAlert(withMessage: response.message)
            }
        }) { (error) in
            self.letsAlert(withMessage: error.asAFError?.errorDescription ?? "Unexpected error")
        }
    }
    
    func inputMessageBarDidTapButtonSendMessage() {
        let text = (inputMessageBar.inputContentView.txtVInputMessage.text ?? "")
        inputMessageBar.sendTextMessage()
        
        let timeStr = dateFormatter.string(from: Date())
        let cmt = Comment.init(courseID: courseVM.course.id, studentID: UserProfile.this.id, stdFN: UserProfile.this.firstName, stdLN: UserProfile.this.lastName, img_url: UserProfile.this.imageUrl, content: text, time: timeStr)
        
        sendComment(cmt: cmt)
    }
    
    func inputMessageBarDidTapButtonFastEmoji() {
    }
    
    func inputMessageBarDidTapButtonPickImage() {
        
    }
    
    func inputMessageBarDidTapButtonCamera() {
    }
    
    func inputMessageBarTxtVDidBecomeFirstResponder() {
        //
    }
    
    func inputMessageBarTxtVDidResignFirstResponder() {
        //
    }
}
