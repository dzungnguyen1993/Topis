//
//  CommentCell.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    // MARK: Initialization
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // load data to UI
    func loadData(comment: Comment) {
        self.avatarImageView.image = UIImage(named: comment.owner.avatar)
        
        self.userNameLabel.text = comment.owner.name
        
        // set contents
        self.contentLabel.text = comment.content
    }
}
