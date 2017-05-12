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
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topicTableView: UITableView!
    
    var topics: [Topic]!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSearchView()
        self.setupTableView()
        
        // set textField delegate
        self.searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationBar()
        
        // load data
        self.loadData()
    }
    
    // MARK: Set-up Layout
    func initSearchView() {
        searchTextField.leftViewMode = UITextFieldViewMode.always
        let searchImgContainer = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 30))
        let leftSearchImage = UIImageView(frame: CGRect(x: 5, y: 5, width: 20.0, height: 20.0))
        leftSearchImage.image = UIImage(named: "search")
        searchImgContainer.addSubview(leftSearchImage)
        searchTextField.leftView = searchImgContainer
    }
    
    func setupTableView() {
        topicTableView.register(UINib(nibName: Constants.Identifiers.topicCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.topicCell)
        topicTableView.separatorStyle = .none
        topicTableView.delegate = self
        topicTableView.dataSource = self
    }
    
    // MARK: Set-up Navigation Bar
    func setupNavigationBar() {
        // set margin
        let margin: CGFloat = 8
        let newSize = self.view.frame.size.width - CGFloat(margin * 2)
        
        UIView.animate(withDuration: 0.3) {
            // clear right button
            self.searchNavigationItem.rightBarButtonItem = nil
            
            self.searchTextField.frame = CGRect(x: 8, y: self.searchTextField.frame.origin.y, width: newSize, height: self.searchTextField.frame.size.height)
        }
    }
    
    func addCancelSearchButton() {
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelSearch))
        
        UIView.animate(withDuration: 0.3) {
            self.searchNavigationItem.rightBarButtonItem = cancel
            cancel.tintColor = UIColor.white
        }
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
        
        // load data
        let topic = self.topics[indexPath.row]
        
        cell.avatarImgView.image = UIImage(named: topic.owner.avatar)
        
        cell.nameLabel.text = topic.owner.name
        
        cell.nameLabel.numberOfLines = 0
        cell.nameLabel.sizeToFit()
    
        // set contents
        cell.contentLabel.text = topic.content
        cell.contentLabel.sizeToFit()
        
        return cell
    }
    
    // update height depends on content
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight: CGFloat = 120
        
        let topic = self.topics[indexPath.row]
        let content = topic.content
        let height = content.heightWithLineBreak(withConstrainedWidth: tableView.frame.size.width, font: UIFont(name: GothamFontName.Book.rawValue, size: 15)!)
        
        return defaultHeight + height
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: Search
extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.addCancelSearchButton()
        return true
    }
    
    func cancelSearch() {
        // remove cancel button from navigation bar
        self.setupNavigationBar()
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
    }
}
