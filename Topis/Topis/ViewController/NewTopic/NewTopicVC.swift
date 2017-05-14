//
//  NewTopicVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class NewTopicVC: BaseViewController {

    // MARK: Initialization
    @IBOutlet weak var inputTextView: UITextView!
    var isSetPlaceHolder: Bool = true
    @IBOutlet weak var placeHolderLabel: UILabel!
    let placeHolderText = "Share your thought!"
    var currentUser: User!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextView.delegate = self
        
        // init placeHolderLabel
        self.currentUser = self.appDelegate.currentUser
        placeHolderLabel.text = placeHolderText
        
        // set user info
        avatarImageView.image = UIImage(named: currentUser.avatar)
        userNameLabel.text = currentUser.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setPlaceHolderText()
        self.titleTextField.becomeFirstResponder()
    }
    
    // MARK: Set Place Holder
    func setPlaceHolderText() {
        isSetPlaceHolder = true
        placeHolderLabel.isHidden = false
    }
    
    // remove place holder
    func removePlaceHolderText() {
        isSetPlaceHolder = false
        placeHolderLabel.isHidden = true
    }

    // MARK: Actions
    @IBAction func cancelPost(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = self.appDelegate.previousIndex
    }
    
    @IBAction func postTopic(_ sender: UIButton) {
        // check if user enter anything
        if self.isUserInputData() == false {
            self.showAlert(withTitle: Constants.warningTitle, message: Constants.messageEnterNothing)
            return
        }
        
        // post new topic
        let topic = Topic()
        topic.id = Utils.createNewUUID()
        topic.title = titleTextField.text!
        topic.content = inputTextView.text
        topic.owner = currentUser
        topic.postedDate = Date()
        
        self.appDelegate.topicList?.add(topic: topic)
        
        // jump to previous tab
        self.tabBarController?.selectedIndex = self.appDelegate.previousIndex
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.reset()
    }
    
    // reset input
    func reset() {
        titleTextField.resignFirstResponder()
        titleTextField.text = ""
        inputTextView.resignFirstResponder()
        inputTextView.text = ""
    }
    
    // check if user has input content
    func isUserInputData() -> Bool {
        return !(isSetPlaceHolder == true || inputTextView.text.characters.count == 0)
    }
}

// MARK: UITextViewDelegate
extension NewTopicVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            self.setPlaceHolderText()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if isSetPlaceHolder == true && text != "" {
            self.removePlaceHolderText()
            return true
        }
    
        let isValidLength = textView.text.characters.count + (text.characters.count - range.length) <= Constants.maximumTopicLength
        
        if isValidLength == false {
            // show alert here
            self.showAlert(withTitle: Constants.warningTitle, message: Constants.messageExceedContentLength)
        }
        
        return isValidLength
    }
}
