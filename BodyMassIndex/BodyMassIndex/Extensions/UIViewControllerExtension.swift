//
//  UIViewControllerExtension.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

extension UIViewController: CommonView {
    
    func showLoader() {
        
        LoadingIndicator.presentLoadingIndicator()
    }
    
    func hideLoader() {
        
        LoadingIndicator.dismissLoadingIndicator()
    }
}
