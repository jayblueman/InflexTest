//
//  MeasurementListViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class MeasurementListViewController: UIViewController {

    var eventHandler: MeasurementListEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MeasurementListViewController: MeasurementListView {
}
