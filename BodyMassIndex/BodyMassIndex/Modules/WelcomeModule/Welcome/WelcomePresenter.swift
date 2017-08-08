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

    init(view: WelcomeView?, router: WelcomeRouter?) {

        self.view = view

        self.router = router
    }
}

extension WelcomePresenter: WelcomeEventHandler {
    
    func loginButtonPressed() {
        //facebook login
        
        FacebookService().login { (isSuccessful, profile) in
            
            if isSuccessful {
                
                self.router?.showMainScreen()
            }
        }
    }
}
