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
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var eventHandler: ProfileEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnBackground))
        self.view.addGestureRecognizer(tapGesture)
        
        let tapGestureOnImageView = UITapGestureRecognizer(target: self, action: #selector(didTapOnImageView))
        self.profileImageView.addGestureRecognizer(tapGestureOnImageView)
        self.profileImageView.isUserInteractionEnabled = true
        
        self.profileHeightTextField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.eventHandler?.viewDidAppear()
    }
    
    @IBAction func saveProfileButtonPressed(_ sender: Any) {
        self.eventHandler?.saveProfileButtonPressed()
    }
    
    @IBAction func deleteProfileButtonPressed(_ sender: Any) {
        self.eventHandler?.deleteProfileButtonPressed()
    }
    
    @IBAction func logutButtonPressed(_ sender: Any) {
        self.eventHandler?.logoutButtonPressed()
    }
    
    func didTapOnBackground() {
        
        self.eventHandler?.didTapOnBackground()
    }
    
    func didTapOnImageView() {
        
        self.eventHandler?.didTapOnImageView()
    }
    
    func textFieldTextDidChange() {
        
        self.eventHandler?.textFieldTextDidChange(textFieldText: self.profileHeightTextField.text ?? "")
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
    
    func showLogoutConfirmAlert() {
        
        let alertController = AJAlertView.confirmAlertController(title: "Kijelentkezés", message: "Biztos kijelentkezel?") { (isConfirmed) in
            
            self.eventHandler?.logout(confirmed: isConfirmed)
        }
        
        self.tabBarController?.present(alertController, animated: true, completion: nil)
    }
    
    func showDeleteProfileConfirmAlert() {
        
        let alertController = AJAlertView.confirmAlertController(title: "Profil törlés", message: "Biztod törlöd a profilt?") { (isConfirmed) in
            
            self.eventHandler?.profileDelete(confirmed: isConfirmed)
        }
        
        self.tabBarController?.present(alertController, animated: true, completion: nil)
    }
    
    func enableSaveButton() {
        
        self.saveButton.isEnabled = true
    }
    
    func disableSaveButton() {
        
        self.saveButton.isEnabled = false
    }
    
    func showCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }else  if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func display(image: UIImage) {
        
        self.profileImageView.image = image
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.eventHandler?.imagePickerController(didFinishPickingImage: image)
        }
        
        dismiss(animated:true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated:true, completion: nil)
    }
}
