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
}
