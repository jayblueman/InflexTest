//
//  WelcomePresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 

class WelcomePresenter {

    weak var view: WelcomeView?

    fileprivate weak var router: WelcomeRouter?
    
    fileprivate var welcomeDataInteractor = WelcomeDataInteractor()
    
    init(view: WelcomeView?, router: WelcomeRouter?) {

        self.view = view

        self.router = router
        
        self.welcomeDataInteractor.presenter = self
    }
}

extension WelcomePresenter: WelcomeEventHandler {
    
    func loginButtonPressed() {
        
        self.welcomeDataInteractor.login()
    }
}

extension WelcomePresenter: WelcomeDataInteractorResult {
    
    func loginSuccessful() {
        self.view?.hideLoader()
        
        self.router?.showMainScreen()
    }
    
    func loginFailed() {
        self.view?.hideLoader()
    }
    
    func firebaseLoginStarted() {
        
        self.view?.showLoader()
    }
    
    func registrationNeeded() {
        
        self.view?.hideLoader()
        
        self.router?.showRegistrationScreen()
    }
}
