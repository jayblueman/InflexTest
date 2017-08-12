//
//  AddMeasurementDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

protocol AddMeasurementDataInteractorResult : class {

    func measurementDidStored(withIdentifier identifier: String)
    
    func measurementStoreFailed()
    
    func profileUpdated()
    
    func profileUpdateFailed()
    
    func imageUploaded()
    
    func imageUploadFailed()
}

class AddMeasurementDataInteractor {
 
    weak var presenter: AddMeasurementDataInteractorResult?
    
    func store(measurement: Measurement) {
        
        FirebaseService.addMeasurement(measurement: measurement) { [unowned self] (isSuccess: Bool, measurementId: String) in
            
            isSuccess ? self.presenter?.measurementDidStored(withIdentifier: measurementId) : self.presenter?.measurementStoreFailed()
        }
    }
    
    func updateProfile() {
        
        FirebaseService.updateProfileData { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.profileUpdated() : self.presenter?.profileUpdateFailed()
        }
    }
    
    func upload(image: UIImage, name: String) {
        
        FileManager.store(image: image, withFilename: name)
        
        FirebaseService.upload(imageName: name) { [unowned self]  (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.imageUploaded() : self.presenter?.imageUploadFailed()
        }
    }
}
