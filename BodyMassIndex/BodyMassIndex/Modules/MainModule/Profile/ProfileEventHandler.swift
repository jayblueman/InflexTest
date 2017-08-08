//
//  ProfileEventHandler.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol ProfileEventHandler {
    
    func didTapOnBackground()
    
    func viewDidLoad()
    
    func keyboardWillAppearOnScreen()
    
    func keyboardWillDisappearFromScreen()
}
