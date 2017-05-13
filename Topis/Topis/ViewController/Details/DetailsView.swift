//
//  DetailsView.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: class {
    func didUpdateHeight()
}

class DetailsView: UIView {
    
    // MARK: Initialization
    @IBOutlet weak var container: UIView!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    // constraints
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerHeight: NSLayoutConstraint!
    
    
    var topic: Topic!
    
    weak var delegate: DetailsViewDelegate?
    @IBOutlet weak var commentTableView: UITableView!
    
    
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
