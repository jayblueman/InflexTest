//
//  MeasurementListPresenter.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation 
import UIKit

class MeasurementListPresenter {
    
    static let emptyDataText = "Vigyél föl új mérést!"
    static let retrieveErrorText = "Hiba történt a mérések lekérése közben, kérlek próbáld meg később"
    static let missingHeightProfileDataText = "Kérlek add meg a magasságodat a profil tabon."
    
    weak var view: MeasurementListView?

    fileprivate weak var router: MeasurementListRouter?

    fileprivate var measurementListDataInteractor = MeasurementListDataInteractor()
    
    fileprivate var measurements = Array<Measurement>()
    
    init(view: MeasurementListView?, router: MeasurementListRouter?) {

        self.view = view

        self.router = router
        
        self.measurementListDataInteractor.presenter = self
    }
    
    func isProfileValid() -> Bool {
        
        guard let profile = ProfileManager.shared.profile else {
            
            return false
        }
        
        return profile.height > 0.0
    }
}

extension MeasurementListPresenter: MeasurementListEventHandler {
    
    func viewDidAppear() {
        
        self.view?.disableAddButton()
        
        if self.isProfileValid() {
            
            self.view?.showLoader()
            
            self.measurementListDataInteractor.retrieveMeasurementList()
        } else {
            self.view?.showPlaceholder(withText: MeasurementListPresenter.missingHeightProfileDataText)
        }
    }
    
    func viewWillAppear() {
        
        self.view?.refreshTableView()
        
        self.view?.hideMeasurementImage()
        
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
    
    func refreshButtonPressed() {
        
        self.view?.showLoader()
        
        self.measurementListDataInteractor.retrieveMeasurementList()
    }
    
    func removeMeasurement(atIndex index: Int) {
        
        self.view?.showDeleteConfirmAlert(withMeasurement: self.measurements[index])
    }
    
    func delete(confirmed: Bool, measurement: Measurement) {
        
        if confirmed {
            
            self.measurementListDataInteractor.delete(measurement: measurement)
            
        }
    }
    
    func didTapOnCell(atIndex index: Int) {
        
        let measurement = measurements[index]
        
        let imageURL = FileManager.filepath(forFilename: measurement.identifier ?? "")
        
        if let image = UIImage(contentsOfFile: imageURL.path) {
            self.view?.displayMeasurementImage(image: image)
        }
    }
    
    func didTapOnMeasurementImage() {
        
        self.view?.hideMeasurementImage()
    }
}

extension MeasurementListPresenter: MeasurementListDataInteractorResult {
    
    func retrieveMeasurementListFailed() {
        
        self.view?.hideLoader()
        
        self.view?.showPlaceholder(withText: MeasurementListPresenter.retrieveErrorText)
        
        self.view?.disableAddButton()
    }
    
    func measurementListRetrieved(measurementList: Array<Measurement>) {
        
        self.view?.enableAddButton()
        
        self.view?.hideLoader()
        
        self.measurements = measurementList.sorted(by: {$0.date < $1.date})
        
        if self.measurements.isEmpty {
            
            self.view?.showPlaceholder(withText: MeasurementListPresenter.emptyDataText)
            
        } else {
            
            self.view?.showList()
            self.view?.refreshTableView()
            
        }
    }
    
    func measurementDeleted() {
        
        self.measurementListDataInteractor.retrieveMeasurementList()
    }
    
    func measurementDeleteFailed() {
        
    }
}
