//
//  AddMeasurementPresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 

class AddMeasurementPresenter {

    weak var view: AddMeasurementView?

    fileprivate weak var router: AddMeasurementRouter?

    init(view: AddMeasurementView?, router: AddMeasurementRouter?) {

        self.view = view

        self.router = router
    }
}

extension AddMeasurementPresenter: AddMeasurementEventHandler {
}
