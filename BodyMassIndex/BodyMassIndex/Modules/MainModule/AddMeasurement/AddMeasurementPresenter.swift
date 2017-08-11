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

    fileprivate var addMeasurementDataInteractor = AddMeasurementDataInteractor()
    var measurementToSave = Measurement(dictionary: ["date":Date()])
    
    init(view: AddMeasurementView?, router: AddMeasurementRouter?) {

        self.view = view

        self.router = router
        
        self.addMeasurementDataInteractor.presenter = self
    }
    
    func checkMeasurementData() {
        
        var isValidData = true
        
        if self.measurementToSave.weight == 0.0{
            isValidData = false
        }
        
        if isValidData {
            
            self.view?.enableAddButton()
            
        } else {
            
            self.view?.disableAddButton()
        }
        
    }
}

extension AddMeasurementPresenter: AddMeasurementEventHandler {
    
    func textFieldTextDidChange(text: String) {
        
        var weightDouble = Double(text) ?? 0.0
        
        if weightDouble < 0.0 {
            weightDouble = 0.0
        }
        
        self.measurementToSave.weight = weightDouble
        
        self.checkMeasurementData()
    }
    
    func datePickerDidChange(date: Date) {
        
        self.measurementToSave.date = date
    }
    
    func addButtonPressed() {
        
        self.addMeasurementDataInteractor.store(measurement: self.measurementToSave)
    }
}

extension AddMeasurementPresenter: AddMeasurementDataInteractorResult {
    
    func measurementStoreStarted() {
        
        self.view?.showLoader()
    }
    
    func measurementStored() {
        
        self.view?.hideLoader()
        
        self.router?.popBack()
    }
    
    func measurementFailedToStore() {
        
        self.view?.hideLoader()
        
        print("faild to store")
    }
}
