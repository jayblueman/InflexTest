//
//  ModuleManager.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 07.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

enum AppState {
    
    case welcome
    case main
}

protocol ModuleManagerDelegate: NSObjectProtocol {
    
    func moduleDidChange(currentModule: ModuleProtocol, animated: Bool)
}

class ModuleManager {

    weak var delegate: ModuleManagerDelegate?
    
    fileprivate var currentState: AppState = .welcome {
        
        didSet {
            
            if let currentModule = self.currentModule {
                
                currentModule.cleanUp()
            }
            
            self.currentModule = self.module(forState: self.currentState)
        }
    }
    
    fileprivate(set) var currentModule: ModuleProtocol!
    
    init(startState: AppState, delegate: ModuleManagerDelegate) {
        
        self.setAppState(startState)
        
        self.delegate = delegate
    }
    
    private func setAppState(_ appState: AppState) {
        
        self.currentState = appState
    }
    
    func setApp(toState: AppState) {
        
        self.currentState = toState
        
        self.delegate?.moduleDidChange(currentModule: self.currentModule, animated: true)
    }
    
    //MARK: - private methods
    
    fileprivate func module(forState: AppState) -> ModuleProtocol {
        
        var module: ModuleProtocol
        
        switch forState {
            
        case .welcome:
            
            module = WelcomeModule(moduleManager: self)
            
        case .main:
            module = WelcomeModule(moduleManager: self)
        }
        
        return module
    }
}
