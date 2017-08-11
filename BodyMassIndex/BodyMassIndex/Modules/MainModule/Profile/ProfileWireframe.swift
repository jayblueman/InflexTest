//
//  ProfileWireframe.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

class ProfileWireframe: MainModuleWireframe {

    fileprivate var presenter: ProfilePresenter?

    fileprivate var view = ProfileViewController()

    override init(mainModule: MainModule) {
        super.init(mainModule: mainModule)

        self.presenter = ProfilePresenter(view: self.view, router: self)

        self.view.eventHandler = self.presenter
        
        self.view.title = "Profile"
    }

// MARK: - Public methods

    func push(_ wireframe: Wireframe) {
        
        self.view.navigationController?.pushViewController(wireframe.viewController(), animated: true)
    }
}

// MARK: - Wireframe protocol methods

extension ProfileWireframe: Wireframe {

    func viewController() -> UIViewController {
        
        return self.view
    }
}

// MARK: - ProfileRouter protocol methods

extension ProfileWireframe: ProfileRouter {
    
    func showLoginScreen() {
        
        self.mainModule?.showLogin()
    }
}
