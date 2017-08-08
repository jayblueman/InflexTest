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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.maximumDate = Date()
        
        self.weightTextField.becomeFirstResponder()
    }
}

extension AddMeasurementViewController: AddMeasurementView {
}
