//
//  ProfileDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol ProfileDataInteractorResult : class {
    
    func profileDidDeleted()
    
    func profileDeleteFailed()
}

class ProfileDataInteractor {
    
    weak var presenter: ProfileDataInteractorResult?
    
    func deleteProfile() {
        
        self.deleteProfileMeasurements()
    }
    
    private func deleteProfileMeasurements() {
        
        FirebaseService.deleteProfileMeasurements { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.deleteProfileData() : self.presenter?.profileDeleteFailed()
        }
    }
    
    private func deleteProfileData() {
        
        FirebaseService.deleteProfile { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.profileDidDeleted() : self.presenter?.profileDeleteFailed()
        }
    }
}
