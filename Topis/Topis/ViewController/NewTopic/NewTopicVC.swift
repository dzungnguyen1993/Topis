//
//  NewTopicVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class NewTopicVC: BaseViewController {

    @IBOutlet weak var inputTextView: UITextView!
    var isSetPlaceHolder: Bool = true
    
    let placeHolderText = "Share your thought!"
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextView.delegate = self
        
        self.currentUser = self.appDelegate.currentUser
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setPlaceHolderText()
        self.inputTextView.becomeFirstResponder()
    }
    
    // MARK: Set Place Holder
    func setPlaceHolderText() {
        isSetPlaceHolder = true
        inputTextView.text = placeHolderText
        inputTextView.textColor = UIColor(hex: Constants.grayTextColor)
    }
    
    func removePlaceHolderText() {
        isSetPlaceHolder = false
        inputTextView.text = ""
        inputTextView.textColor = UIColor(hex: Constants.blackTextColor)
    }

    // MARK: Actions
    @IBAction func cancelPost(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func postTopic(_ sender: UIButton) {
        // post new topic
        let topic = Topic()
        topic.id = Utils.createNewUUID()
        topic.content = inputTextView.text
        topic.owner = currentUser
        topic.postedDate = Date()
        
        self.appDelegate.listTopic.append(topic)
        
        // reset
        self.reset()
        
        // jump to tab home
        self.tabBarController?.selectedIndex = 0
    }
    
    func reset() {
        inputTextView.resignFirstResponder()
        inputTextView.text = ""
    }
}

// MARK: UITextViewDelegate
extension NewTopicVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if isSetPlaceHolder == true {
            self.removePlaceHolderText()
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            self.setPlaceHolderText()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isValidLength = textView.text.characters.count + (text.characters.count - range.length) <= Constants.maximumTopicLength
        
        if isValidLength == false {
            // show alert here
            self.showAlert(withTitle: Constants.warningTitle, message: Constants.messageExceedContentLength)
        }
        
        return isValidLength
    }
}
