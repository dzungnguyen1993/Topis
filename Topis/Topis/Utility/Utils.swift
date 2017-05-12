//
//  Utils.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class Utils {
    static func createNewUUID() -> String {
        return UUID().uuidString
    }
    
    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
