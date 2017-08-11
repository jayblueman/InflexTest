//
//  RegistrationWireframe.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 11.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

class RegistrationWireframe: WelcomeModuleWireframe {

    fileprivate var presenter: RegistrationPresenter?

    fileprivate var view = RegistrationViewController()

    override init(welcomeModule: WelcomeModule) {
        super.init(welcomeModule: welcomeModule)

        self.presenter = RegistrationPresenter(view: self.view, router: self)

        self.view.eventHandler = self.presenter
    }

// MARK: - Public methods

    func push(_ wireframe: Wireframe) {
        self.view.navigationController?.pushViewController(wireframe.viewController(), animated: true)
    }
}

// MARK: - Wireframe protocol methods

extension RegistrationWireframe: Wireframe {

    func viewController() -> UIViewController {
        return self.view
    }
}

// MARK: - RegistrationRouter protocol methods

extension RegistrationWireframe: RegistrationRouter {

    func showMainScreen() {
        
        self.welcomeModule?.loginSuccessful()
    }
}
