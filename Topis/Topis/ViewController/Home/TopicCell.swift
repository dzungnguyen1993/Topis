//
//  TopicCell.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/10/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

protocol TopicCellDelegate: class {
    func tapUpvote(forTopic topic: Topic)
    func tapDownvote(forTopic topic: Topic)
    func tapComment(forTopic topic: Topic)
}

class TopicCell: UITableViewCell {
    // MARK: Initialization
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var upvoteView: UIView!
    @IBOutlet weak var downvoteView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    weak var delegate: TopicCellDelegate?
    
    var topic: Topic!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initialize UI
        self.setupLayout()
        
        // add targets to views
        self.addTargets()
    }
    
    // set-up UI
    func setupLayout() {
        // set border color
        self.containerView.layer.borderColor = UIColor(hex: 0xD6D6D6).cgColor
        self.containerView.layer.borderWidth = 1.0
        
        // round avatar image
        //        avatarImgView.layer.cornerRadius = avatarImgView.bounds.size.width / 2
        //        avatarImgView.layer.masksToBounds = true
        
        // set label alignment
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        
        self.selectionStyle = .none
    }
    
    func loadData(topic: Topic) {
        self.topic = topic
        
        self.avatarImgView.image = UIImage(named: topic.owner.avatar)
        
        self.nameLabel.text = topic.owner.name
        
        self.titleLabel.text = topic.title
        
        // set contents
        self.contentLabel.text = topic.content
//        self.contentLabel.sizeToFit()
        
        // set number of upvote, downvote, comments
        self.upLabel.text = "\(topic.upvote)"
        self.downLabel.text = "\(topic.downvote)"
        self.commentLabel.text = "\(topic.comments.count)"
        
        // set date
        self.dateLabel.text = "Posted on " + topic.postedDate.toDateTimeString()
    }
    
    // add targets for views
    func addTargets() {
        // upvote
        let tapUpvoteGesture = UITapGestureRecognizer(target: self, action: #selector(tapUpvote))
        self.upvoteView.addGestureRecognizer(tapUpvoteGesture)
        
        // downvote
        let tapDownvoteGesture = UITapGestureRecognizer(target: self, action: #selector(tapDownvote))
        self.downvoteView.addGestureRecognizer(tapDownvoteGesture)
        
        // comment
        let tapCommentGesture = UITapGestureRecognizer(target: self, action: #selector(tapComment))
        self.commentView.addGestureRecognizer(tapCommentGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: IBActions
    func tapUpvote(sender: UITapGestureRecognizer) {
        topic.upvote += 1
        upLabel.text = "\(topic.upvote)"
        
        self.delegate?.tapUpvote(forTopic: self.topic)
    }
    
    func tapDownvote(sender: UITapGestureRecognizer) {
        topic.downvote += 1
        downLabel.text = "\(topic.downvote)"
        
        self.delegate?.tapUpvote(forTopic: self.topic)
    }
    
    func tapComment(sender: UITapGestureRecognizer) {
        self.delegate?.tapComment(forTopic: self.topic)
    }
}
