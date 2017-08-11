//
//  RegistrationPresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 

class RegistrationPresenter {

    weak var view: RegistrationView?

    fileprivate weak var router: RegistrationRouter?

    fileprivate var registrationDataInteractor = RegistrationDataInteractor()
    
    fileprivate var date = Date()
    fileprivate var isMale = true
    
    init(view: RegistrationView?, router: RegistrationRouter?) {

        self.view = view

        self.router = router
        
        self.registrationDataInteractor.presenter = self
    }
}

extension RegistrationPresenter: RegistrationEventHandler {
    
    func registrationButtonPressed() {
        
        self.view?.showLoader()
        
        self.registrationDataInteractor.registrateUser(dob: date, isMale: isMale)
    }
    
    func segmentedControlerDidChangeValue(segmentedValue: Int) {
        
        self.isMale = segmentedValue == 0
    }
    
    func datePickerDidChangeValue(date: Date) {
        
        self.date = date
    }
}

extension RegistrationPresenter: RegistrationDataInteractorResult {
    
    func registrationFailed() {
        
    }
    
    func registrationSucceeded() {
        self.router?.showMainScreen()
    }
}
