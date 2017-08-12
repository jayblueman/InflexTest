//
//  ProfileView.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileView: CommonView {

    var eventHandler: ProfileEventHandler? {get set}

    func hideKeyboard()
    
    func moveContainerUpwards()
    
    func moveContainerDownwards()
    
    func updateContent()
    
    func showLogoutConfirmAlert()
    
    func showDeleteProfileConfirmAlert()
    
    func enableSaveButton()
    
    func disableSaveButton()
    
    func showCamera()
    
    func display(image: UIImage)
}
