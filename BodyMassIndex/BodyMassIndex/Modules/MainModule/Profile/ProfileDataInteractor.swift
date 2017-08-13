//
//  ProfileDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileDataInteractorResult : class {
    
    func profileDidDeleted()
    
    func profileDeleteFailed()
    
    func profileDidUpdate()
    
    func profileUpdateFailed()
    
    func profileImageDidStored()
    
    func profileImageStoreFailed()
    
    func profileImageDownloaded()
    
    func profileImageDownloadFailed()
}

class ProfileDataInteractor {
    
    weak var presenter: ProfileDataInteractorResult?
    
    //TODO: remove images from the server
    func deleteProfile() {
        
        self.deleteProfileMeasurements()
    }
    
    func updateProfile() {
        
        FirebaseService.updateProfileData { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.profileDidUpdate() : self.presenter?.profileUpdateFailed()
        }
    }
    
    private func deleteProfileMeasurements() {
        
        FirebaseService.deleteProfileMeasurements { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.deleteProfileImages() : self.presenter?.profileDeleteFailed()
        }
    }
    
    private func deleteProfileImages() {
        if self.profileImage() != nil {
            
            FirebaseService.deleteProfileImage { [unowned self] (isSuccess: Bool) in
                
                if isSuccess {
                    
                    FileManager.deleteFile(filename: "ProfileImage")
                    self.deleteProfileData()
                    
                } else {
                    self.presenter?.profileDeleteFailed()
                }
            }
        } else {
            
            self.deleteProfileData()
        }
    }
    
    private func deleteProfileData() {
        
        FirebaseService.deleteProfile { [unowned self] (isSuccess: Bool) in
            
            isSuccess ? self.presenter?.profileDidDeleted() : self.presenter?.profileDeleteFailed()
        }
    }
    
    func store(image: UIImage) {
        
        FileManager.store(image: image, withFilename: "ProfileImage")
        
        FirebaseService.upload(imageName: "ProfileImage") { [unowned self] (isSuccess) in
            
            isSuccess ? self.presenter?.profileImageDidStored() : self.presenter?.profileImageStoreFailed()
        }
    }
    
    func downloadProfilePicture() {
        
        FirebaseService.download(imageName: "ProfileImage") { [unowned self] (isSuccess) in
            
            isSuccess ? self.presenter?.profileImageDownloaded() : self.presenter?.profileImageDownloadFailed()
        }
    }
    
    func profileImage() -> UIImage? {
        
        let imageURL = FileManager.filepath(forFilename: "ProfileImage")
        
        return UIImage(contentsOfFile: imageURL.path)
    }
}
