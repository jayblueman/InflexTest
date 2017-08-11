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
    
}

class WelcomeDataInteractor {
    
    weak var presenter: WelcomeDataInteractorResult?
    
    func login() {
        FacebookService().login {  [unowned self] (isSuccessful: Bool) in
            
            if isSuccessful {
                
                self.presenter?.firebaseLoginStarted()
                
                FirebaseService.signIn(completion: {  [unowned self] (isSuccessful: Bool, userProfile) in
                    
                    isSuccessful ? self.presenter?.loginSuccessful() : self.presenter?.loginFailed()
                })
                
            } else {
                
               self.presenter?.loginFailed()
            }
        }
    }
}
