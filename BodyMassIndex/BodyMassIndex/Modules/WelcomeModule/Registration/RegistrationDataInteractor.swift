//
//  RegistrationDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol RegistrationDataInteractorResult: class {
    
    func registrationSucceeded()
    
    func registrationFailed()
}

class RegistrationDataInteractor {
    
    weak var presenter: RegistrationDataInteractorResult?
    
    func registrateUser(dob: Date, isMale: Bool) {
        
        ProfileManager.shared.profile?.birthDate = dob.readableFormat()
        ProfileManager.shared.profile?.isMale = isMale
        
        FirebaseService.updateProfileData { (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.registrationSucceeded() : self.presenter?.registrationFailed()
        }
        
    }
}
