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

    override init(welcomeModule: WelcomeModule) {
        super.init(welcomeModule: welcomeModule)

        self.presenter = WelcomePresenter(view: self.view, router: self)

        self.view.eventHandler = self.presenter
    }

// MARK: - Public methods

    func push(_ wireframe: Wireframe) {
        self.view.navigationController?.pushViewController(wireframe.viewController(), animated: true)
    }
}

// MARK: - Wireframe protocol methods

extension WelcomeWireframe: Wireframe {

    func viewController() -> UIViewController {
        return self.view
    }
}

// MARK: - WelcomeRouter protocol methods

extension WelcomeWireframe: WelcomeRouter {
}
