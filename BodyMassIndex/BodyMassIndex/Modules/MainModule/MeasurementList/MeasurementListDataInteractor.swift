//
//  MeasurementListDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol MeasurementListDataInteractorResult : class
{
    func retrieveMeasurementListFailed()
    func measurementListRetrieved(measurementList: Array<Measurement>)
    
    func measurementDeleteFailed()
    func measurementDeleted()
}

class MeasurementListDataInteractor: NSObject
{
    
    weak var presenter: MeasurementListDataInteractorResult?
    
    func retrieveMeasurementList() {
        
        FirebaseService.measurements { [unowned self] (isSuccess: Bool, measurements: [Measurement]) in
            
            isSuccess ? self.presenter?.measurementListRetrieved(measurementList: measurements) : self.presenter?.retrieveMeasurementListFailed()
        }
        
    }
    
    func delete(measurement: Measurement) {
        
        FirebaseService.delete(measurement: measurement) { (isSuccess: Bool) in
            isSuccess ? self.presenter?.measurementDeleted() : self.presenter?.measurementDeleteFailed()
        }
    }
}
