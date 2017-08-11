//
//  AddMeasurementWireframe.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//
import Foundation
import UIKit

class AddMeasurementWireframe: MainModuleWireframe {

    fileprivate var presenter: AddMeasurementPresenter?

    fileprivate var view = AddMeasurementViewController()

    override init(mainModule: MainModule) {
        super.init(mainModule: mainModule)

        self.presenter = AddMeasurementPresenter(view: self.view, router: self)

        self.view.eventHandler = self.presenter
    }

// MARK: - Public methods

    func push(_ wireframe: Wireframe) {
        self.view.navigationController?.pushViewController(wireframe.viewController(), animated: true)
    }
}

// MARK: - Wireframe protocol methods

extension AddMeasurementWireframe: Wireframe {

    func viewController() -> UIViewController {
        return self.view
    }
}

// MARK: - AddMeasurementRouter protocol methods

extension AddMeasurementWireframe: AddMeasurementRouter {
    
    func popBack() {
        self.view.navigationController?.popViewController(animated: true)
    }
}
