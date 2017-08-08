//
//  ProfileViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileGenderLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var profileWeightLabel: UILabel!
    @IBOutlet weak var profileHeightTextField: UITextField!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var eventHandler: ProfileEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnBackground))
        self.view.addGestureRecognizer(tapGesture)
        
        self.eventHandler?.viewDidLoad()
    }
    
    func didTapOnBackground() {
        
        self.eventHandler?.didTapOnBackground()
    }
}

extension ProfileViewController: ProfileView {
    
    func updateContent() {
        
        self.profileNameLabel.text = ProfileManager.shared.profile?.name ?? ""
        self.profileGenderLabel.text = (ProfileManager.shared.profile?.isMale ?? true) ? "Férfi" : "Nő"
        self.dateOfBirthLabel.text = ProfileManager.shared.profile?.birthDate ?? ""
        self.profileWeightLabel.text = "\(ProfileManager.shared.profile?.weight ?? 0) kg"
        self.profileHeightTextField.text = String(Int((ProfileManager.shared.profile?.height ?? 0.0) * 100.0))
    }
    
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
    
    func moveContainerUpwards() {
        
        let optimalViewHeight = self.view.bounds.height - 225
        
        let textFieldY = self.profileHeightTextField.frame.minY
        
        if optimalViewHeight < textFieldY {
            
            let topConstraint = textFieldY - optimalViewHeight
            
            self.topConstraint.constant = -topConstraint
        }
        
        
        UIView.animate(withDuration: 0.33) {
            
            self.view.layoutIfNeeded()
        }
    }
    
    func moveContainerDownwards() {
        
        self.topConstraint.constant = 0
        
        UIView.animate(withDuration: 0.33) {
            
            self.view.layoutIfNeeded()
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.eventHandler?.keyboardWillAppearOnScreen()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        self.eventHandler?.keyboardWillDisappearFromScreen()
        return true
    }
    
}
