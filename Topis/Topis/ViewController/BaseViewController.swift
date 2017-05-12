//
//  BaseViewController.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/12/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit
import PopupDialog

class BaseViewController: UIViewController {

    lazy var appDelegate = {
        return Utils.appDelegate()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // show alert
    func showAlert(withTitle title: String, message: String) {
        let popup = PopupDialog(title: title, message: message, image: nil, buttonAlignment: .vertical, transitionStyle: .zoomIn, gestureDismissal: true, completion: nil)
        let buttonOne = CancelButton(title: "OK") {
            popup.dismiss()
        }
        
        popup.addButton(buttonOne)
        self.present(popup, animated: true, completion: nil)
    }
    
    // MARK: Show Details
    func showDetails(topic: Topic) {
        let detailsVC = DetailsVC(nibName: Constants.ViewControllers.detailsVC, bundle: nil)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
