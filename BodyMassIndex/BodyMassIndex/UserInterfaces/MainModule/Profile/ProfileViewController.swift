//
//  ProfileViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var eventHandler: ProfileEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController: ProfileView {
}
