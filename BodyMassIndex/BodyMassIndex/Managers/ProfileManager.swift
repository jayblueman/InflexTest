//
//  ProfileManager.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileManager {

    static let shared = ProfileManager()
    
    var profile: Profile?
    
    fileprivate var user: User? {
        didSet {
            guard let user = self.user else {
                return
            }
            
            self.profile = Profile(name: user.displayName ?? "", isMale: true, birthDate: "", weight: 23, profilePicture: "", height: 2.32)
        }
    }
    private init() {
        
    }
    
    func logOutUser() {
        
        self.profile = nil
    }
    
    func loginUser(userProfile: Profile) {
        
        self.profile = userProfile
    }
    
    func loginUser(user: User) {
        
        self.user = user
    }
}
