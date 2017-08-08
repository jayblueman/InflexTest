//
//  MeasurementListWireframe.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

class MeasurementListWireframe: MainModuleWireframe {

    fileprivate var presenter: MeasurementListPresenter?

    fileprivate var view = MeasurementListViewController()
    
    fileprivate var addMeasurementWireframe: AddMeasurementWireframe?
    
    fileprivate var navigationController: UINavigationController!

    override init(mainModule: MainModule) {
        super.init(mainModule: mainModule)

        self.presenter = MeasurementListPresenter(view: self.view, router: self)

        self.view.eventHandler = self.presenter
        
        self.view.title = "MeasurementList"
        
        self.navigationController = UINavigationController(rootViewController: self.view)
        self.navigationController.navigationBar.isTranslucent = false
    }

// MARK: - Public methods

    func push(_ wireframe: Wireframe) {
        
        self.view.navigationController?.pushViewController(wireframe.viewController(), animated: true)
    }
}

// MARK: - Wireframe protocol methods

extension MeasurementListWireframe: Wireframe {

    func viewController() -> UIViewController {
        return self.navigationController
    }
}

// MARK: - MeasurementListRouter protocol methods

extension MeasurementListWireframe: MeasurementListRouter {
    
    func showAddMeasurement() {
        
        self.addMeasurementWireframe = nil
        
        guard let mainModule = self.mainModule else {
            return
        }
        
        self.addMeasurementWireframe = AddMeasurementWireframe(mainModule: mainModule)
        
        guard let addMeasurementWireframe = self.addMeasurementWireframe else {
            return
        }
        
        self.push(addMeasurementWireframe)
    }
}
