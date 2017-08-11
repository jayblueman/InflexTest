//
//  MeasurementListView.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol MeasurementListView: class {

    var eventHandler: MeasurementListEventHandler? {get set}

    func showPlaceholder()
    func showList()
    
    func refreshTableView()
}