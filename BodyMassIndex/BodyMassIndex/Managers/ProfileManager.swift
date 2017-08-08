//
//  ProfileManager.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class ProfileManager {

    static let shared = ProfileManager()
    
    var profile: Profile?
    
    private init() {
        
    }
    
    func logOutUser() {
        
        self.profile = nil
    }
    
    func loginUser(userProfile: Profile) {
        
        self.profile = userProfile
    }
}
