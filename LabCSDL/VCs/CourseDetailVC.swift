//
//  CourseDetailVC.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/8/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class CourseDetailHeaderView: UIView {
    
    let lblTitle: UILabel = {
        let temp = UILabel()
        temp.text = "Học lập trình iOS với Objective C"
        temp.textColor = AppColor.white
        temp.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return temp
    }()
    
    let lblInstitution: UILabel = {
        let temp = UILabel()
        temp.text = "HCMUT University"
        temp.textColor = AppColor.white
        temp.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return temp
    }()
    
    let imgV: UIImageView = {
        let temp = UIImageView()
        temp.clipsToBounds = true
        temp.backgroundColor = AppColor.white
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.themeColor
        
        addSubviews(subviews: lblTitle, lblInstitution, imgV)
        
        addConstraintsWith(format: "V:[v0]-5-[v1]-40-|", views: lblTitle, lblInstitution)
        lblTitle.topAnchor(equalTo: self.layoutMarginsGuide.topAnchor)
        imgV.centerYAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imgV.makeCircle(corner: 15)
        
        addSameConstraintsWith(format: "H:|-10-[v0]-10-|", for: lblTitle, lblInstitution)
        addConstraintsWith(format: "H:|-10-[v0]", views: imgV)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CourseInfoView: UIView {
    
    let lblTitle: UILabel = {
        let temp = UILabel()
        temp.textColor = AppColor.black
        temp.text = "Course Introduction"
        temp.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return temp
    }()
    
    let txtVDescription: UITextView = {
        let temp = UITextView()
        temp.textColor = AppColor.black
        temp.isEditable = false
        temp.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce feugiat tortor sed sodales faucibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque rutrum laoreet elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam mauris justo, dapibus vitae feugiat ultrices, imperdiet non urna. Quisque felis lacus, mattis sed volutpat eu, pulvinar id metus."
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.white
        
        addSubviews(subviews: lblTitle, txtVDescription)
        addConstraintsWith(format: "V:|-[v0][v1]-|", views: lblTitle, txtVDescription)
        addConstraintsWith(format: "H:|-8-[v0]-8-|", views: lblTitle)
        addConstraintsWith(format: "H:|-5-[v0]-5-|", views: txtVDescription)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


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

@objc protocol CourseCommentsViewDelegate {
    func loadMoreData(commentsView: CourseCommentsView)
    func presentAction(commentsView: CourseCommentsView, cmtIndex: Int)
}


class CourseCommentsView: UIView {

    weak var delegate: CourseCommentsViewDelegate?
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.register(CommentTableViewCell.self, forCellReuseIdentifier: "CELL_ID")
        temp.keyboardDismissMode = .interactive
        temp.separatorStyle = .none
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        addSubviews(subviews: tableView)
        tableView.makeFullWithSuperView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var vms = [CommentVM]()
    var isOutOfData = false
    func reloadData(commentVMs: [CommentVM], isOutOfData: Bool) {
        vms = commentVMs
        self.isOutOfData = isOutOfData
        tableView.reloadData()
    }
}

extension CourseCommentsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vms[indexPath.row].heightOfCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID") as! CommentTableViewCell
        cell.vm = vms[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == vms.count - 2 && !isOutOfData {
            delegate?.loadMoreData(commentsView: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cmt = vms[indexPath.row]
        if UserProfile.this.id == cmt.comment.studentID {
            delegate?.presentAction(commentsView: self, cmtIndex: indexPath.row)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CourseDetailVCLayout: BaseViewControllerLayout {
    
    let vHeader: CourseDetailHeaderView = {
        let temp = CourseDetailHeaderView()
        return temp
    }()
    
    let segControl: UISegmentedControl = {
        let temp = UISegmentedControl(items: ["Home", "Lesson", "Forum", "Grades", "Comment"])
        temp.selectedSegmentIndex = 0
        temp.backgroundColor = AppColor.themeColor
        return temp
    }()
    
    let vInfo: CourseInfoView = {
        let temp = CourseInfoView()
        return temp
    }()
    
    let vComments: CourseCommentsView = {
        let temp = CourseCommentsView()
        return temp
    }()
    
    lazy var inputMessageBar: IMBInputMessageBar = {
        let temp = IMBInputMessageBar()
        
        return temp
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    var vCurrentShowing: UIView!
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.backgroundColor = AppColor.black
        
        view.addSubviews(subviews: segControl, vHeader, vComments, vInfo)
        view.addConstraintsWith(format: "V:[v0]-20-[v1(30)]", views: vHeader, segControl)
        vHeader.topAnchor(equalTo: view.topAnchor)
        view.addSameConstraintsWith(format: "H:|[v0]|", for: vHeader)
        view.addConstraintsWith(format: "H:|-10-[v0]-10-|", views: segControl)
        
        view.addConstraintsWith(format: "V:[v0]-10-[v1]|", views: segControl, vInfo)
        vInfo.makeFullWidthWithSuperView()
        
        view.addConstraintsWith(format: "V:[v0]-10-[v1]|", views: segControl, vComments)
        vComments.makeFullWidthWithSuperView()
        
        vCurrentShowing = vInfo
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        
        let dismissItem = UIBarButtonItem.init(image: AppIcon.dismissVC, style: .done, target: self, action: #selector(dismissMySelf))
        navigationItem.leftBarButtonItem = dismissItem
        navigationController?.navigationBar.barTintColor = AppColor.themeColor
        navigationController?.navigationBar.tintColor = AppColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
    }

}


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
