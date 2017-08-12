//
//  MeasurementListView.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit

protocol MeasurementListView: CommonView {

    var eventHandler: MeasurementListEventHandler? {get set}

    func showPlaceholder(withText text: String)
    
    func showList()
    
    func refreshTableView()
    
    func enableAddButton()
    
    func disableAddButton()
    
    func showDeleteConfirmAlert(withMeasurement measurement: Measurement)
    
    func displayMeasurementImage(image: UIImage)
    
    func hideMeasurementImage()
}
