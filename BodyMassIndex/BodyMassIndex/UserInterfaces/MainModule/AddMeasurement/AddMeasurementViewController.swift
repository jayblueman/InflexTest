//
//  AddMeasurementViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class AddMeasurementViewController: UIViewController {

    var eventHandler: AddMeasurementEventHandler?

    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var addMeasureButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.maximumDate = Date()
        
        self.weightTextField.becomeFirstResponder()
        
        self.addMeasureButton.isEnabled = false
        
        self.weightTextField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(cameraButtonPressed))
    }
    
    func cameraButtonPressed() {
        self.eventHandler?.cameraButtonPressed()
    }
    
    func textFieldTextDidChange() {
        
        self.eventHandler?.textFieldTextDidChange(text: self.weightTextField.text ?? "")
    }
    
    @IBAction func datePickerDidChangeValue(_ sender: Any) {
        
        self.eventHandler?.datePickerDidChange(date: self.datePicker.date)
    }
    
    @IBAction func addMeasureButtonPresssed(_ sender: Any) {
        
        self.eventHandler?.addButtonPressed()
        
    }
}

extension AddMeasurementViewController: AddMeasurementView {
    
    func enableAddButton() {
        
        self.addMeasureButton.isEnabled = true
    }
    
    func disableAddButton() {
        
        self.addMeasureButton.isEnabled = false
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
}

extension AddMeasurementViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
