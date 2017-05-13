//
//  DetailsView.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: class {
    func willShowAlert(withTitle: String, message: String)
}

class DetailsView: UIView {
    
    // MARK: Initialization
    @IBOutlet weak var container: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var inputCommentView: UIView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentPlaceHolder: UILabel!
    
    // layout constraints
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintInputBottom: NSLayoutConstraint!
    @IBOutlet weak var constraintInputHeight: NSLayoutConstraint!
    
    var topic: Topic!
    var currentUser: User!
    
    weak var delegate: DetailsViewDelegate?
    @IBOutlet weak var commentTableView: UITableView!
    var isSetPlaceHolder: Bool = true
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.contentView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.contentView]))
    }
    
    func loadView() {
        self.loadContent()
        
        self.loadComments()
        
        self.adjustContainerHeight()
        
        // set-up input comment view
        commentTextView.delegate = self
        // add keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = 2.0
        commentTextView.layer.cornerRadius = 10.0
    }
    
    // MARK: Content
    func loadContent() {
        self.avatarImageView.image = UIImage(named: topic.owner.avatar)
        
        self.userNameLabel.text = topic.owner.name
        
        self.titleLabel.text = topic.title
        self.sizeToFit()
        
        self.contentLabel.text = topic.content
        self.sizeToFit()
    }
    
    // MARK: Comment
    func loadComments() {
        self.setupCommentTable()
        
        commentTableView.reloadData()
    }
    
    // MARK: Input Comment
    @IBAction func postComment(_ sender: UIButton) {
        let comment = Comment()
        comment.id = Utils.createNewUUID()
        comment.owner = currentUser
        comment.content = commentTextView.text
        comment.postedDate = Date()
        
        topic.comments.append(comment)
        
//        self.delegate?.didPostComment()
        // reload views after posting comments
        commentTextView.text = ""
        commentTextView.resignFirstResponder()
        self.adjustContainerHeight()
        self.commentTableView.reloadData()
    }
}

extension DetailsView {
    func adjustContainerHeight() {
        let topHeight: CGFloat = 66
        
        // calculate height of content view
        let contentHeight = adjustContentHeight()
        
        // calculate height of comment view
        let commentHeight = adjustCommentTableHeight()
        
        constraintContainerHeight.constant = topHeight + contentHeight + commentHeight
    }
    
    func adjustContentHeight() -> CGFloat {
        let defaultTopicHeight: CGFloat = 24 // space between labels
        
        let titleHeight = topic.title.heightWithLineBreak(withConstrainedWidth: titleLabel.frame.size.width, font: Constants.contentFont)
        
        let contentHeight = topic.content.heightWithLineBreak(withConstrainedWidth: contentLabel.frame.size.width, font: Constants.contentFont)
        
        let topicContentHeight = defaultTopicHeight + titleHeight + contentHeight
        constraintContentHeight.constant = topicContentHeight
        
        return topicContentHeight
    }
    
    func adjustCommentTableHeight() -> CGFloat {
        let defaultHeight: CGFloat = 36
        
        var totalHeight: CGFloat = 0
        
        for comment in topic.comments {
            let height = self.getHeight(forComment: comment, constraintWidth: commentTableView.frame.size.width)
            
            totalHeight += height
        }
        
        return defaultHeight + totalHeight
    }
    
}

// MARK: Comments
extension DetailsView {
    func setupCommentTable() {
        commentTableView.register(UINib(nibName: Constants.Identifiers.commentCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.commentCell)
        commentTableView.separatorStyle = .none
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    
    func getHeight(forComment comment: Comment, constraintWidth: CGFloat) -> CGFloat {
        let defaultHeight: CGFloat = 40 // sorry me in the future for this hardcode
        
        let content = comment.content
        let height = content.heightWithLineBreak(withConstrainedWidth: constraintWidth, font: Constants.contentFont)
        
        return defaultHeight + height
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.commentCell, for: indexPath) as! CommentCell
        
        cell.loadData(comment: topic.comments[indexPath.row])
        
        return cell
    }
    
    // update height depends on content
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight: CGFloat = 40 // sorry me in the future for this hardcode
        
        let content = topic.comments[indexPath.row].content
        let height = content.heightWithLineBreak(withConstrainedWidth: tableView.frame.size.width, font: Constants.contentFont)
        
        return defaultHeight + height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: TextViewDelegate
extension DetailsView: UITextViewDelegate {
    // MARK: Set Place Holder
    func setPlaceHolderText() {
        isSetPlaceHolder = true
        commentPlaceHolder.isHidden = false
    }
    
    func removePlaceHolderText() {
        isSetPlaceHolder = false
        commentPlaceHolder.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // check if text is empty to set placeholder
        if textView.text == "" {
            self.setPlaceHolderText()
        }
        
        // adjust input size
        // kind of a magic number here
        // will figure out that later
        let height = textView.text.heightWithLineBreak(withConstrainedWidth: textView.frame.size.width, font: Constants.contentFont) * 1.5
        constraintInputHeight.constant = max(height, 30)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if isSetPlaceHolder == true && text != "" {
            self.removePlaceHolderText()
            return true
        }
        
        let isValidLength = textView.text.characters.count + (text.characters.count - range.length) <= Constants.maximumCommentLength
        
        if isValidLength == false {
            // show alert here
            self.delegate?.willShowAlert(withTitle: Constants.warningTitle, message: Constants.commentExceedContentLength)
        }
        
        return isValidLength
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            // put inputView right in top of keyboard
            UIView.animate(withDuration: 0.5, animations: { 
                self.constraintInputBottom.constant = keyboardHeight - Constants.bottomTabbarHeight
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) { 
            self.constraintInputBottom.constant = 0
        }
    }
}
