//
//  AJAlertView.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 09..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class AJAlertView: NSObject {

    static func confirmAlertController(title: String, message: String, completion: @escaping (_ isConfirmed: Bool)->Void) -> UIAlertController {
        
        let cancelAction = UIAlertAction(title: "mégse", style: UIAlertActionStyle.cancel) { (action) in
            completion(false)
        }
        
        let confirmAction = UIAlertAction(title: "igen", style: UIAlertActionStyle.default) { (action) in
            completion(true)
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        return alertController
    }
}
