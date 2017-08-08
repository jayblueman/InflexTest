//
//  MeasurementListPresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 

class MeasurementListPresenter {

    weak var view: MeasurementListView?

    fileprivate weak var router: MeasurementListRouter?

    init(view: MeasurementListView?, router: MeasurementListRouter?) {

        self.view = view

        self.router = router
    }
}

extension MeasurementListPresenter: MeasurementListEventHandler {
}
