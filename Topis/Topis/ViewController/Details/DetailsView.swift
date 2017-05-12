//
//  DetailsView.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    @IBOutlet var contentView: UIView!

    var topic: Topic!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.contentView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.contentView]))
        
        self.loadView()
    }
    
    func loadView() {
        
    }
}
