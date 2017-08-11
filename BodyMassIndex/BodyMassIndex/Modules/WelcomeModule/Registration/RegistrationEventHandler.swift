//
//  RegistrationEventHandler.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol RegistrationEventHandler {
    
    func registrationButtonPressed()
    
    func segmentedControlerDidChangeValue(segmentedValue: Int)
    
    func datePickerDidChangeValue(date: Date)
}
