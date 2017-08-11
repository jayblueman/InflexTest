//
//  AddMeasurementEventHandler.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol AddMeasurementEventHandler {
    
    func textFieldTextDidChange(text: String)
    func datePickerDidChange(date: Date)
    
    func addButtonPressed()
    
}
