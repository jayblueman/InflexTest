//
//  MainModule.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class MainModule: Module {
    
    fileprivate(set) var measurementListWireframe: MeasurementListWireframe!
    
    fileprivate(set) var profileWireframe: ProfileWireframe!
    
    fileprivate var tabBarController: UITabBarController!
    
    override func initModule() {
        
        self.measurementListWireframe = MeasurementListWireframe(mainModule: self)
        
        self.profileWireframe = ProfileWireframe(mainModule: self)
        
        self.tabBarController = UITabBarController()
        
        self.tabBarController.tabBar.isTranslucent = false
        
        self.tabBarController.viewControllers = [self.measurementListWireframe.viewController(), self.profileWireframe.viewController()]
    }
    
    func showLogin() {
        
        self.moduleManager.setApp(toState: .welcome)
    }
}

extension MainModule: ModuleProtocol {
    
    func rootWireframe() -> Wireframe {
        
        return self.measurementListWireframe
    }
    
    func rootViewController() -> UIViewController {
        
        return self.tabBarController
    }
    
    func cleanUp() {
        
    }
}
