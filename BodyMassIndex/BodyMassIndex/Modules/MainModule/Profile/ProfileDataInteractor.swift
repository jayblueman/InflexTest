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
    
    func profileDidUpdate()
    
    func profileUpdateFailed()
}

class ProfileDataInteractor {
    
    weak var presenter: ProfileDataInteractorResult?
    
    func deleteProfile() {
        
        self.deleteProfileMeasurements()
    }
    
    func updateProfile() {
        
        FirebaseService.updateProfileData { (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.profileDidUpdate() : self.presenter?.profileUpdateFailed()
        }
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
