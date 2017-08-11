//
//  WelcomeModule.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class WelcomeModule: Module {
    
    fileprivate(set) var welcomeWireframe: WelcomeWireframe!
    
    override func initModule() {
        
        self.welcomeWireframe = WelcomeWireframe(welcomeModule: self)
    }
    
    func loginSuccessful() {
        
        self.moduleManager.setApp(toState: .main)
    }
}

extension WelcomeModule: ModuleProtocol {
    
    func rootWireframe() -> Wireframe {
        
        return self.welcomeWireframe
    }
    
    func rootViewController() -> UIViewController {
        
        return self.welcomeWireframe.viewController()
    }
    
    func cleanUp() {
        
    }
}
