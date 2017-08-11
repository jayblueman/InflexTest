//
//  WelcomeDataInteractor.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol WelcomeDataInteractorResult : class{
    
    func loginSuccessful()
    
    func loginFailed()
    
    func firebaseLoginStarted()
    
    func registrationNeeded()
}

class WelcomeDataInteractor {
    
    weak var presenter: WelcomeDataInteractorResult?
    
    func login() {
        
        FacebookService().login {  [unowned self] (isSuccessful: Bool) in
            
            if !isSuccessful {
                self.presenter?.loginFailed()
                return
            }
            
            self.presenter?.firebaseLoginStarted()
            
            FirebaseService.signIn(completion: {  [unowned self] (isSuccessful: Bool, userProfile) in
                
                if !isSuccessful {
                    self.presenter?.loginFailed()
                    return
                }
                
                ProfileManager.shared.loginUser(user: userProfile)
                
                FirebaseService.retrieveProfile(completion: {  [unowned self](isSuccess, retrievedProfile) in
                    
                    if !isSuccessful {
                        self.presenter?.loginFailed()
                        return
                    }
                    
                    if let profile = retrievedProfile {
                        
                        ProfileManager.shared.loginUser(userProfile: profile)
                        
                        self.presenter?.loginSuccessful()
                        return
                    }
                    
                    self.presenter?.registrationNeeded()
                })
            })
        }
    }
}
