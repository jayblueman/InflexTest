//
//  WelcomeViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var eventHandler: WelcomeEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        self.eventHandler?.loginButtonPressed()
    }
}

extension WelcomeViewController: WelcomeView {
}
