//
//  MeasurementListEventHandler.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol MeasurementListEventHandler {
    
    func viewDidAppear()
    
    func viewWillAppear()
    
    func numberOfElementsInTheList() -> Int
    
    func measurement(forIndex index: Int) -> Measurement
    
    func addMeasurementButtonPressed()
    
    func refreshButtonPressed()

    func removeMeasurement(atIndex index: Int)
}
