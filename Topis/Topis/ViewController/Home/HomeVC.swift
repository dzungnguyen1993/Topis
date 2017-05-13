//
//  HomeVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    // MARK: Initialization
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topicTableView: UITableView!
    
    var topics: [Topic]!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // load data
        self.loadData()
    }
    
    // MARK: Set-up Layout
    func setupTableView() {
        topicTableView.register(UINib(nibName: Constants.Identifiers.topicCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.topicCell)
        topicTableView.separatorStyle = .none
        topicTableView.delegate = self
        topicTableView.dataSource = self
    }
    
    // MARK: Load data
    func loadData() {
        self.topics = self.appDelegate.listTopic
        self.topicTableView.reloadData()
    }
}

// MARK: Content View
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.topicCell, for: indexPath) as! TopicCell
        // set cell's delegate
        cell.delegate = self
        
        // load data
        let topic = self.topics[indexPath.row]
        
        cell.loadData(topic: topic)
        
        return cell
    }
    
    // update height depends on content
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight: CGFloat = 136
        
        let topic = self.topics[indexPath.row]
        let content = topic.content
        let height = content.heightWithLineBreak(withConstrainedWidth: tableView.frame.size.width, font: Constants.contentFont)
        
        return defaultHeight + height
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension HomeVC: TopicCellDelegate {
    func tapUpvote(forTopic topic: Topic) {
        
    }
    
    func tapDownvote(forTopic topic: Topic) {
        
    }
    
    func tapComment(forTopic topic: Topic) {
        self.showDetails(topic: topic)
    }
}
