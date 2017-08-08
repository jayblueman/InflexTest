//
//  AppDelegate.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var moduleManager : ModuleManager!
    var rootViewController: UIViewController {
        
        return self.moduleManager.currentModule.rootViewController()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if self.window == nil {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        self.moduleManager = ModuleManager(startState: .welcome, delegate: self)
        
        let rootNavigationController = UINavigationController(rootViewController: self.rootViewController)
        rootNavigationController.isNavigationBarHidden  = true
        self.window?.rootViewController = rootNavigationController
        
        self.window?.makeKeyAndVisible()
        
        FacebookService().application(application: application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
}

extension AppDelegate : ModuleManagerDelegate
{
    func moduleDidChange(currentModule: ModuleProtocol, animated: Bool)
    {
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            
            navigationController.setViewControllers([self.rootViewController], animated: true)
        }
    }
}
