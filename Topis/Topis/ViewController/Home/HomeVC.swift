//
//  HomeVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: Initialization
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topicTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSearchView()
        self.setupTableView()
        
        // set textField delegate
        self.searchTextField.delegate = self
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
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.topicCell, for: indexPath) as! TopicCell
        
        // load data
        cell.avatarImgView.image = UIImage(named: "avatar.jpg")
        cell.nameLabel.numberOfLines = 0
        cell.nameLabel.sizeToFit()
        
        cell.contentLabel.text = "a\na\na af valm"
        
//        let string = "a\na\na a g awt \n"
//        let height = string.height(withConstrainedWidth: 320, font: UIFont(name: GothamFontName.Book.rawValue, size: 12)!)
//        print(height)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
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
}
