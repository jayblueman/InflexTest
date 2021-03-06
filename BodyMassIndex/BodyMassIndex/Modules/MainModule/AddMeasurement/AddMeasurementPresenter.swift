//
//  AddMeasurementPresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 
import UIKit

class AddMeasurementPresenter {

    weak var view: AddMeasurementView?

    fileprivate weak var router: AddMeasurementRouter?

    fileprivate var addMeasurementDataInteractor = AddMeasurementDataInteractor()
    var measurementToSave = Measurement(dictionary: ["date":Date()])
    
    var imageToUpload: UIImage?
    
    init(view: AddMeasurementView?, router: AddMeasurementRouter?) {

        self.view = view

        self.router = router
        
        self.addMeasurementDataInteractor.presenter = self
    }
    
    func checkMeasurementData() {
        
        var isValidData = true
        
        if self.measurementToSave.weight == 0 {
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
        
        var weightDouble = Int(text) ?? 0
        
        if weightDouble < 0 {
            weightDouble = 0
        }
        
        self.measurementToSave.weight = weightDouble
        
        self.checkMeasurementData()
    }
    
    func datePickerDidChange(date: Date) {
        
        self.measurementToSave.date = date
    }
    
    func addButtonPressed() {
        
        self.view?.showLoader()
        
        self.addMeasurementDataInteractor.store(measurement: self.measurementToSave)
    }
    
    func cameraButtonPressed() {
        
        self.view?.showCamera()
    }
    
    func imagePickerController(didFinishPickingImage image: UIImage) {
        
        self.imageToUpload = image
    }
}

extension AddMeasurementPresenter: AddMeasurementDataInteractorResult {
    
    func measurementDidStored(withIdentifier identifier: String) {
        
        if self.imageToUpload == nil {
            
            if self.measurementToSave.date.isToday() {
                
                ProfileManager.shared.profile?.weight = self.measurementToSave.weight
                
                self.addMeasurementDataInteractor.updateProfile()
                
            } else {
                
                self.view?.hideLoader()
                
                self.router?.popBack()
            }
        } else {
            self.addMeasurementDataInteractor.upload(image: self.imageToUpload!, name: identifier)
        }
    }
    
    func measurementStoreFailed() {
        
        self.view?.hideLoader()
        
        print("faild to store")
    }
    
    func profileUpdated() {
        
        self.view?.hideLoader()
        
        self.router?.popBack()
    }
    
    func profileUpdateFailed() {
        
        self.view?.hideLoader()
        
        print("faild to store")
    }
    
    func imageUploaded() {
        
        if self.measurementToSave.date.isToday() {
            
            ProfileManager.shared.profile?.weight = self.measurementToSave.weight
            
            self.addMeasurementDataInteractor.updateProfile()
            
        } else {
            
            self.view?.hideLoader()
            
            self.router?.popBack()
        }
    }
    
    func imageUploadFailed() {
        
        self.view?.hideLoader()
        
        print("faild to store")
    }
}
