//
//  ExploreVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class ExploreVC: BaseViewController {

    // MARK: Initialization
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchNavigationItem: UINavigationItem!

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var listView: ListView!
    
    // for search
    var searchResult: [Topic] = [Topic]()
    var topicList: TopicList!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set textField delegate
        self.searchTextField.delegate = self
        
        // search view
        self.initSearchView()
        
        // list view
        self.initListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationBar()
        
        // load data
        self.topicList = TopicPostedDateList(topics: (self.appDelegate.topicList?.topics)!)
        self.searchResult.removeAll()
        
        listView.topicList = TopicPostedDateList(topics: (self.appDelegate.topicList?.topics)!)
        listView.loadViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.resetViews()
    }

    func resetViews() {
        self.listView.isHidden = false
        
        // reset search
        self.resetSearch()
    }
    
    // MARK: Set up Navigation Bar
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
    
    // MARK: Set up search view
    func initSearchView() {
        searchTextField.leftViewMode = UITextFieldViewMode.always
        let searchImgContainer = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 30))
        let leftSearchImage = UIImageView(frame: CGRect(x: 5, y: 5, width: 20.0, height: 20.0))
        leftSearchImage.image = UIImage(named: "search")
        searchImgContainer.addSubview(leftSearchImage)
        searchTextField.leftView = searchImgContainer
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.register(UINib(nibName: Constants.Identifiers.smallTopicCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.smallTopicCell)
        searchTableView.separatorStyle = .none
    }
    
    @IBAction func searchValueChanged(_ sender: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        self.perform(#selector(searchForResult(withText:)), with: sender.text!, afterDelay: 0.2)
    }
    
    // MARK: Set up list view
    func initListView() {
        listView.initViews()
        listView.delegate = self
    }
}

extension ExploreVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.addCancelSearchButton()
        
        self.searchView.isHidden = false
        self.listView.isHidden = true
        return true
    }
    
    func cancelSearch() {
        // remove cancel button from navigation bar
        self.setupNavigationBar()
        
        self.resetViews()
    }

    func resetSearch() {
        searchView.isHidden = true
        
        searchResult.removeAll()
        searchTableView.reloadData()
        
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
    }
    
    // search topics which name contains text
    func searchForResult(withText text: String) {
        searchResult = self.topicList.filter(text: text)
        
        self.searchTableView.reloadData()
    }
}

// MARK: Search
extension ExploreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.smallTopicCell, for: indexPath) as! SmallTopicCell
        
        cell.loadData(topic: searchResult[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails(topic: searchResult[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension ExploreVC: ListViewDelegate {
    func willShowDetails(topic: Topic) {
        self.showDetails(topic: topic)
    }
}
