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

    fileprivate var measurementListDataInteractor = MeasurementListDataInteractor()
    
    fileprivate var measurements = Array<Measurement>()
    
    init(view: MeasurementListView?, router: MeasurementListRouter?) {

        self.view = view

        self.router = router
        
        self.measurementListDataInteractor.presenter = self
    }
}

extension MeasurementListPresenter: MeasurementListEventHandler {
    
    func viewDidAppear() {
        
        self.view?.showLoader()
        
        self.measurementListDataInteractor.retrieveMeasurementList()
    }
    
    func viewWillAppear() {
        
        self.view?.refreshTableView()
    }
    
    func numberOfElementsInTheList() -> Int {
        
        return self.measurements.count
    }
    
    func measurement(forIndex index: Int) -> Measurement {
        
        return self.measurements[index]
    }
    
    func addMeasurementButtonPressed() {
        
        self.router?.showAddMeasurement()
    }
    
    func removeMeasurement(atIndex index: Int) {
        self.measurements.remove(at: index)
        
        self.view?.refreshTableView()
    }
}

extension MeasurementListPresenter: MeasurementListDataInteractorResult {
    
    func retrieveMeasurementListFailed() {
        
        self.view?.hideLoader()
        
        self.view?.showPlaceholder()
    }
    
    func measurementListRetrieved(measurementList: Array<Measurement>) {
        
        self.view?.hideLoader()
        
        self.measurements = measurementList
        
        if self.measurements.isEmpty {
            
            self.view?.showPlaceholder()
            
        } else {
            
            self.view?.showList()
            self.view?.refreshTableView()
            
        }
    }
}
