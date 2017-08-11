//
//  ProfilePresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 

class ProfilePresenter {

    weak var view: ProfileView?

    fileprivate weak var router: ProfileRouter?

    fileprivate var profileDataInteractor = ProfileDataInteractor()
    
    init(view: ProfileView?, router: ProfileRouter?) {

        self.view = view

        self.router = router
        
        self.profileDataInteractor.presenter = self
    }
    
    func logoutUser() {
        
        FirebaseService.logout()
        
        self.router?.showLoginScreen()
    }
}

extension ProfilePresenter: ProfileEventHandler {
    
    func textFieldTextDidChange(textFieldText: String) {
        
        ProfileManager.shared.profile?.height = (Double(textFieldText) ?? 0.0) / 100.0
        
        self.view?.enableSaveButton()
    }
    
    func didTapOnBackground() {
        
        self.view?.hideKeyboard()
    }
    
    func viewDidAppear() {
        
        self.view?.updateContent()
    }
    
    func keyboardWillAppearOnScreen() {
        
        self.view?.moveContainerUpwards()
    }
    
    func keyboardWillDisappearFromScreen() {
        
        self.view?.moveContainerDownwards()
    }
    
    func saveProfileButtonPressed() {
        
        self.view?.showLoader()
        
        self.profileDataInteractor.updateProfile()
    }
    
    func logoutButtonPressed() {
        self.view?.showLogoutConfirmAlert()
    }
    
    func deleteProfileButtonPressed() {
        
        self.view?.showDeleteProfileConfirmAlert()
    }
    
    func profileDelete(confirmed: Bool) {
        
        if confirmed {
            
            self.view?.showLoader()
            
            self.profileDataInteractor.deleteProfile()
        }
    }
    
    func logout(confirmed: Bool) {
        
        if confirmed {
            
            self.logoutUser()
        }
    }
}

extension ProfilePresenter: ProfileDataInteractorResult {
    
    func profileDidDeleted() {

        self.view?.hideLoader()
        
        self.logoutUser()
    }
    
    func profileDeleteFailed() {
        
        self.view?.hideLoader()
    }
    
    func profileDidUpdate() {
        
        self.view?.hideLoader()
        
        self.view?.disableSaveButton()
    }
    
    func profileUpdateFailed() {
        
        self.view?.hideLoader()
    }
}
