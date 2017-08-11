//
//  MeasurementListView.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

protocol MeasurementListView: CommonView {

    var eventHandler: MeasurementListEventHandler? {get set}

    func showPlaceholder(withText text: String)
    
    func showList()
    
    func refreshTableView()
    
    func enableAddButton()
    
    func disableAddButton()
}
