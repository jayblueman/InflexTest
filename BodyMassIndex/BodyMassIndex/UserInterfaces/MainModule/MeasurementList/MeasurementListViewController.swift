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
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventHandler: MeasurementListEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MeasurementListCellTableViewCell", bundle: nil), forCellReuseIdentifier: MeasurementListCellTableViewCell.identifier())
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addButtonPressed))
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        if( traitCollection.forceTouchCapability == .available){
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.eventHandler?.viewWillAppear()
    }
    
    func addButtonPressed() {
        
        self.eventHandler?.addMeasurementButtonPressed()
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
    
    func showPlaceholder() {
        
        self.emptyScreenPlaceholder.isHidden = false
        
        self.tableView.isHidden = true
    }
    
    func showList() {
        
        self.emptyScreenPlaceholder.isHidden = true
        
        self.tableView.isHidden = false
    }
    
    func refreshTableView() {
        
        self.tableView.reloadData()
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
        
        return cell
    }
}

extension MeasurementListViewController: UITableViewDelegate {
}
