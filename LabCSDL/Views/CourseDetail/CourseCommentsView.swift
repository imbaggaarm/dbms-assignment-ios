//
//  CourseCommentsView.swift
//  LabCSDL
//
//  Created by Imbaggaarm on 12/9/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

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
