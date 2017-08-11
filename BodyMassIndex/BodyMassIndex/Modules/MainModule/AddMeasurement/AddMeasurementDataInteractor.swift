//
//  AddMeasurementDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol AddMeasurementDataInteractorResult : class {
    
    func measurementStoreStarted()
    
    func measurementStored()
    
    func measurementFailedToStore()
}

class AddMeasurementDataInteractor {
 
    weak var presenter: AddMeasurementDataInteractorResult?
    
    func store(measurement: Measurement) {
        
        FirebaseService.addMeasurement(measurement: measurement) { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.measurementStored() : self.presenter?.measurementFailedToStore()
        }
    }
}
