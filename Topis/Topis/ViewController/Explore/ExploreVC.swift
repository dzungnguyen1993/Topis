//
//  ExploreVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class ExploreVC: UIViewController {

    // MARK: Initialization
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchNavigationItem: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // set textField delegate
        self.searchTextField.delegate = self
        
        self.initSearchView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationBar()
        
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
}

extension ExploreVC: UITextFieldDelegate {
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
