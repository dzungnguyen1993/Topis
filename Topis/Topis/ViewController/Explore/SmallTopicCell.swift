//
//  SmallTopicCell.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/13/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class SmallTopicCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var topicNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // load data to UI
    func loadData(topic: Topic) {
        self.avatarImageView.image = UIImage(named: topic.owner.avatar)
        self.userNameLabel.text = topic.owner.name
        self.topicNameLabel.text = topic.title
    }
    
}
