//
//  MeasurementListViewController.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08.
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class MeasurementListViewController: UIViewController {

    @IBOutlet weak var emptyScreenPlaceholder: UIView!
    @IBOutlet weak var placeHolderTextLabel: UILabel!
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var measurementImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventHandler: MeasurementListEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MeasurementListCellTableViewCell", bundle: nil), forCellReuseIdentifier: MeasurementListCellTableViewCell.identifier())
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addButtonPressed))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(refreshButtonPressed))
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        if( traitCollection.forceTouchCapability == .available){
            
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnMeasurementImage))
        
        self.imageContainer.isUserInteractionEnabled = true
        self.measurementImage.isUserInteractionEnabled = true
        
        self.measurementImage.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.eventHandler?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.eventHandler?.viewDidAppear()
    }
    
    func didTapOnMeasurementImage() {
        
        self.eventHandler?.didTapOnMeasurementImage()
    }
    
    func addButtonPressed() {
        
        self.eventHandler?.addMeasurementButtonPressed()
    }
    
    func refreshButtonPressed() {
        
        self.eventHandler?.refreshButtonPressed()
    }
    
    //Called, when long press occurred
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                self.eventHandler?.removeMeasurement(atIndex: indexPath.row)
            }
        }
    }
}

extension MeasurementListViewController: MeasurementListView {
    
    func showPlaceholder(withText text: String) {
        
        self.emptyScreenPlaceholder.isHidden = false
        
        self.tableView.isHidden = true
        
        self.placeHolderTextLabel.text = text
    }
    
    func showList() {
        
        self.emptyScreenPlaceholder.isHidden = true
        
        self.tableView.isHidden = false
    }
    
    func refreshTableView() {
        
        self.tableView.reloadData()
    }
    
    func disableAddButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func enableAddButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func showDeleteConfirmAlert(withMeasurement measurement: Measurement) {
        
        let alertController = AJAlertView.confirmAlertController(title: "Törlés", message: "Biztos torlöd?") { (isConfirmed) in
            
            self.eventHandler?.delete(confirmed: isConfirmed, measurement: measurement)
        }
        
        self.tabBarController?.present(alertController, animated: true, completion: nil)
    }
    
    func displayMeasurementImage(image: UIImage) {
        
        self.measurementImage.image = image
        self.imageContainer.isHidden = false
    }
    
    func hideMeasurementImage() {
        
        self.imageContainer.isHidden = true
    }
}

extension MeasurementListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventHandler?.numberOfElementsInTheList() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementListCellTableViewCell.identifier(), for: indexPath) as! MeasurementListCellTableViewCell
        
        cell.measurement = self.eventHandler?.measurement(forIndex: indexPath.row)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
}

extension MeasurementListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.eventHandler?.didTapOnCell(atIndex: indexPath.row)
        
    }
}
