//
//  Measurement.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

struct Measurement {
    
    var identifier: String
    var date: Date
    var weight: Int = 0
    
    var bmi: Double {
        
        let profile = ProfileManager.shared.profile ?? Profile.defaultProfile()
        
        return ((Double(self.weight) / profile.height) / profile.height)
    }
    
    var bmiString: String {
        
        return String(format: "%.2f", self.bmi)
    }
    
    init(dictionary: Dictionary<String, Any>) {
        
        let dateString = dictionary["date"] as? String
        
        self.identifier = dictionary["identifier"] as? String ?? "identifier"
        self.date = dateString?.dateFromString() ?? Date()
        
        let weightString = dictionary["weight"] as? String ?? "0.0"
        
        self.weight = Int(weightString) ?? 0
    }
}
