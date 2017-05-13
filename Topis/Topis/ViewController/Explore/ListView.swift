//
//  ListView.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/13/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

protocol ListViewDelegate: class {
    func willShowDetails(topic: Topic)
}

class ListView: UIView {

    // MARK: Initialization
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var topicTableView: UITableView!

    var topicList: TopicList!
    
    weak var delegate: ListViewDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        Bundle.main.loadNibNamed("ListView", owner: self, options: nil)
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.contentView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.contentView]))
        
        // set delegate for text field
        self.filterTextField.delegate = self
    }

    func initViews() {
        topicTableView.register(UINib(nibName: Constants.Identifiers.topicCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.topicCell)
        topicTableView.separatorStyle = .none
        topicTableView.delegate = self
        topicTableView.dataSource = self
    }
    
    func loadViews() {
        filterTextField.text = ""
        topicTableView.reloadData()
    }
}

extension ListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight: CGFloat = 136
        
        let topic = topicList[indexPath.row]
        let content = topic.content
        let height = content.heightWithLineBreak(withConstrainedWidth: tableView.frame.size.width, font: Constants.contentFont)
        
        return defaultHeight + height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.topicCell, for: indexPath) as! TopicCell
        
        cell.loadData(topic: topicList[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.delegate?.willShowDetails(topic: self.displayedTopics[indexPath.row])
    }
}

extension ListView: TopicCellDelegate {
    func tapUpvote(forTopic topic: Topic) {
        
    }
    
    func tapDownvote(forTopic topic: Topic) {
        
    }
    
    func tapComment(forTopic topic: Topic) {
        self.delegate?.willShowDetails(topic: topic)
    }
}

// MARK: Filter
extension ListView: UITextFieldDelegate, UIPopoverPresentationControllerDelegate, FilterVCDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // show popover
        let popOver = FilterVC(nibName: Constants.ViewControllers.filterVC, bundle: nil)
        
        // set the presentation style
        popOver.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popOver.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        
        popOver.popoverPresentationController?.delegate = self
        popOver.popoverPresentationController?.sourceView = textField
        popOver.popoverPresentationController?.sourceRect = textField.bounds
        popOver.preferredContentSize = CGSize(width: 300, height: 200)
        
        popOver.delegate = self
        
        // present the popover
        let viewController = self.delegate as? UIViewController
        viewController?.present(popOver, animated: true, completion: nil)
        
        return false
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
    
    func pickUpvote() {
        topicList = TopicUpvoteList(topics: self.topicList.topics)
        filterTextField.text = Constants.filterOptions[0]
        self.topicTableView.reloadData()
    }
    
    func pickDownvote() {
        topicList = TopicDownvoteList(topics: self.topicList.topics)
        filterTextField.text = Constants.filterOptions[1]
        self.topicTableView.reloadData()
    }
    
    func pickPostedDate() {
        topicList = TopicPostedDateList(topics: self.topicList.topics)
        filterTextField.text = Constants.filterOptions[2]
        self.topicTableView.reloadData()
    }
}
