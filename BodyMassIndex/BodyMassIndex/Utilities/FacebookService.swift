//
//  FacebookService.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class FacebookService: NSObject {

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return SDKApplicationDelegate.shared.application(application, open: url, options: [UIApplicationOpenURLOptionsKey.sourceApplication : sourceApplication ?? "", UIApplicationOpenURLOptionsKey.annotation: annotation])
    }

    func login(completion: @escaping (Bool, LoginResult)->Void) {
        
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile], viewController: nil) { (loginResult) in
            
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                completion(true, loginResult)
            }
        }
    }
}
