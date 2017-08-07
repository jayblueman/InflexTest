//
//  Module.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol ModuleProtocol {
    
    //Returns the root wireframe of the module
    func rootWireframe() -> Wireframe
    
    //Cancel all pending data request, cancel running animations
    func cleanUp()
}

class Module: NSObject {
    
    weak var moduleManager: ModuleManager!
    
    init(moduleManager: ModuleManager) {
        super.init()
        
        self.moduleManager = moduleManager
        
        self.initModule()
    }
    
    func initModule() {
        
    }
}
