//
//  RegistrationViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    var eventHandler: RegistrationEventHandler?

    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registrationButtonPressed(_ sender: Any) {
        
        self.eventHandler?.registrationButtonPressed()
    }
    
    @IBAction func segmentedControlerDidChangeValue(_ sender: Any) {
        self.eventHandler?.segmentedControlerDidChangeValue(segmentedValue: segmentedControl.selectedSegmentIndex)
    }
    @IBAction func datePickerDidChangeValue(_ sender: Any) {
        self.eventHandler?.datePickerDidChangeValue(date: self.datePickerView.date)
    }
}

extension RegistrationViewController: RegistrationView {
}
