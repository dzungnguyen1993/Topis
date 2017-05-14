//
//  DetailsVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class DetailsVC: BaseViewController {

    var topic: Topic!
    @IBOutlet weak var detailsView: DetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailsView.topic = topic
        detailsView.currentUser = self.appDelegate.currentUser
        detailsView.loadView()
        
        detailsView.delegate = self
    }

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    // pop to root view of this current tab before navigating to other tab in TabBarController
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension DetailsVC: DetailsViewDelegate {
    func willShowAlert(withTitle title: String, message: String) {
        self.showAlert(withTitle: title, message: message)
    }
}
