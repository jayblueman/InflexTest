//
//  WelcomeWireframe.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

class WelcomeWireframe: WelcomeModuleWireframe {

    fileprivate var presenter: WelcomePresenter?

    fileprivate var view = WelcomeViewController()
    
    fileprivate var registrationWireframe: RegistrationWireframe?
    
    fileprivate var navigationController: UINavigationController!

    override init(welcomeModule: WelcomeModule) {
        super.init(welcomeModule: welcomeModule)

        self.presenter = WelcomePresenter(view: self.view, router: self)

        self.view.eventHandler = self.presenter
        
        self.navigationController = UINavigationController(rootViewController: self.view)
        self.navigationController.navigationBar.isTranslucent = false
    }

// MARK: - Public methods

    func push(_ wireframe: Wireframe) {
        self.view.navigationController?.pushViewController(wireframe.viewController(), animated: true)
    }
}

// MARK: - Wireframe protocol methods

extension WelcomeWireframe: Wireframe {

    func viewController() -> UIViewController {
        return self.navigationController
    }
}

// MARK: - WelcomeRouter protocol methods

extension WelcomeWireframe: WelcomeRouter {
    
    func showMainScreen() {
        
        self.welcomeModule?.loginSuccessful()
    }
    
    func showRegistrationScreen() {
        
        guard let welcomeModule = self.welcomeModule else {
            return
        }
        
        self.registrationWireframe = RegistrationWireframe(welcomeModule: welcomeModule)
        
        guard let registrationWireframe = self.registrationWireframe else {
            return
        }
        
        self.push(registrationWireframe)
    }
}
