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

    fileprivate var measurements = Array<Measurement>()
    
    init(view: MeasurementListView?, router: MeasurementListRouter?) {

        self.view = view

        self.router = router
        
        self.measurements.append(Measurement(date: Date(), weight: 116))
        self.measurements.append(Measurement(date: Date(), weight: 96))
        self.measurements.append(Measurement(date: Date(), weight: 86))
        self.measurements.append(Measurement(date: Date(), weight: 46))
    }
}

extension MeasurementListPresenter: MeasurementListEventHandler {
    
    func viewDidAppear() {
        
    }
    
    func numberOfElementsInTheList() -> Int {
        
        return self.measurements.count
    }
    
    func measurement(forIndex index: Int) -> Measurement {
        
        return self.measurements[index]
    }
    
    func addMeasurementButtonPressed() {
        
        self.measurements.append(Measurement(date: Date(), weight: 46))
        
        self.view?.refreshTableView()
    }
    
    func removeMeasurement(atIndex index: Int) {
        self.measurements.remove(at: index)
        
        self.view?.refreshTableView()
    }
}

extension MeasurementListPresenter: MeasurementListDataInteractorResult {
    
    func retrieveMeasurementListFailed() {
        
    }
    
    func measurementListRetrieved(measurementList: Array<Measurement>) {
        
        if measurementList.isEmpty {
            
            self.view?.showPlaceholder()
            
        } else {
            
            self.view?.showList()
            
        }
    }
}
