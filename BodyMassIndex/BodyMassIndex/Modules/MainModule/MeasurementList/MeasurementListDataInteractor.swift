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
    var weight: Double = 0.0
    
    var bmi: Double {
        
        let profile = ProfileManager.shared.profile ?? Profile.defaultProfile()
        
        return ((self.weight / profile.height) / profile.height)
    }
    
    var bmiString: String {
        
        return String(format: "%.2f", self.bmi)
    }
    
    init(dictionary: Dictionary<String, Any>) {
        
        let dateString = dictionary["date"] as? String
        
        self.date = dateString?.dateFromString() ?? Date()
        
        let weightString = dictionary["weight"] as? String ?? "0.0"
        
        self.weight = Double(weightString) ?? 0.0
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
        
        FirebaseService.measurements { (isSuccess, measurements) in
            
            isSuccess ? self.presenter?.measurementListRetrieved(measurementList: measurements) : self.presenter?.retrieveMeasurementListFailed()
        }
        
    }
}
