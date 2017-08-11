//
//  Profile.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

struct Profile {
    
    var name: String
    var isMale: Bool
    var birthDate: String
    var weight: Int
    var profilePicture: String
    var height: Double
    
    static func defaultProfile() -> Profile {
        
        return Profile(name: "name", isMale: true, birthDate: "1986.08.08.", weight: 85, profilePicture: "asdasdsadas", height: 1.76)
    }
    
    func dictionary() -> Dictionary<String, Any> {
        
        return ["name": self.name,
                "isMale": (self.isMale ? "1" : "0"),
                "dob": self.birthDate,
                "weight": String(self.weight),
                "profilePicture": self.profilePicture,
                "height": String(self.height)]
    }
}
