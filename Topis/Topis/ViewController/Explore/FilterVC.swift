//
//  FilterVC.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/13/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

protocol FilterVCDelegate: class {
    func pickUpvote()
    func pickDownvote()
    func pickPostedDate()
}

class FilterVC: UIViewController {

    // MARK: Initialization
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FilterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension FilterVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.filterOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = Constants.filterOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.delegate?.pickUpvote()
        case 1:
            self.delegate?.pickDownvote()
        default:
            self.delegate?.pickPostedDate()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
