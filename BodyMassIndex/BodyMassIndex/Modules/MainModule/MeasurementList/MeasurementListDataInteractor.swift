//
//  MeasurementListDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

struct Measurement {
    
    var date: Date
    var weight: Double
    
    var bmi: Double {
        
        let profile = ProfileManager.shared.profile ?? Profile.defaultProfile()
        
        return ((self.weight / profile.height) / profile.height)
    }
    
    var bmiString: String {
        
        return String(format: "%.2f", self.bmi)
    }
}

protocol MeasurementListDataInteractorResult : class
{
    func retrieveMeasurementListFailed()
    func measurementListRetrieved(measurementList: Array<Measurement>)
}

class MeasurementListDataInteractor: NSObject
{
    
    weak var presenter: MeasurementListDataInteractorResult?
    
    func retrieveMeasurementList() {
        
        self.presenter?.measurementListRetrieved(measurementList: [])
        
    }
}
