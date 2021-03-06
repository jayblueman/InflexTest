//
//  AddMeasurementView.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol AddMeasurementView: CommonView {

    var eventHandler: AddMeasurementEventHandler? {get set}
    
    func enableAddButton()
    
    func disableAddButton()
    
    func showCamera()
}

