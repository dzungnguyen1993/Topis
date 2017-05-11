//
//  NewTopicVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class NewTopicVC: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    var isSetPlaceHolder: Bool = true
    
    let placeHolderText = "Share your thought!"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextView.delegate = self
        
        // set textview placeholder
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
        inputTextView.resignFirstResponder()
    }
    
    @IBAction func postTopic(_ sender: UIButton) {
        // do something here
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
}
