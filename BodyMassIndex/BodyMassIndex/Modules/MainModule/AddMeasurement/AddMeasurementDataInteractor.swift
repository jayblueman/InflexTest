//
//  AddMeasurementDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol AddMeasurementDataInteractorResult : class {

    func measurementDidStored()
    
    func measurementStoreFailed()
    
    func profileUpdated()
    
    func profileUpdateFailed()
}

class AddMeasurementDataInteractor {
 
    weak var presenter: AddMeasurementDataInteractorResult?
    
    func store(measurement: Measurement) {
        
        FirebaseService.addMeasurement(measurement: measurement) { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.measurementDidStored() : self.presenter?.measurementStoreFailed()
        }
    }
    
    func updateProfiel() {
        
        FirebaseService.updateProfileData { (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.profileUpdated() : self.presenter?.profileUpdateFailed()
        }
    }
}
