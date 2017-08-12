//
//  ProfileEventHandler.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileEventHandler {
    
    func textFieldTextDidChange(textFieldText: String)
    
    func didTapOnBackground()
    
    func didTapOnImageView()
    
    func viewDidAppear()
    
    func keyboardWillAppearOnScreen()
    
    func keyboardWillDisappearFromScreen()
    
    func logoutButtonPressed()
    
    func saveProfileButtonPressed()
    
    func deleteProfileButtonPressed()
    
    func profileDelete(confirmed: Bool)
    
    func logout(confirmed: Bool)
    
    func imagePickerController(didFinishPickingImage image: UIImage)
}
