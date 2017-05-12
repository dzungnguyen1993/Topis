//
//  TopicCell.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/10/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var constraintContentLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
