//
//  MeasurementListCellTableViewCell.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit

class MeasurementListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var measurementImageView: UIImageView!
    
    var measurement: Measurement? {
        
        didSet {
            
            self.updateViews()
        }
    }
    
    class func identifier() -> String {
        
        return "MeasurementListCellTableViewCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func updateViews() {
        
        self.dateLabel.text = self.measurement?.date.readableFormat() ?? ""
        self.bmiLabel.text = self.measurement?.bmiString ?? ""
        self.weightLabel.text = "\(self.measurement?.weight ?? 0) kg"
        
        DispatchQueue.global(qos: .background).async {
            self.tryToSetMeasurementImage()
            
        }
    }
    
    fileprivate func tryToSetMeasurementImage() {
        
        let imageURL = FileManager.filepath(forFilename: self.measurement?.identifier ?? "")
        
        if let image = UIImage(contentsOfFile: imageURL.path) {
            
            DispatchQueue.main.async {
                self.measurementImageView.image = image
            }
        } else {
            DispatchQueue.main.async {
                
            self.measurementImageView.image = UIImage(named: "defaultImage")
            }
            
            self.downloadMeasurementImage()
        }
        
    }
    
    fileprivate func downloadMeasurementImage() {
        
        FirebaseService.download(imageName: self.measurement?.identifier ?? "") { (isSuccess) in
            
            let imageURL = FileManager.filepath(forFilename: self.measurement?.identifier ?? "")
            
            if let image = UIImage(contentsOfFile: imageURL.path) {
                DispatchQueue.main.async {
                    self.measurementImageView.image = image
                }
                
            } else {
                DispatchQueue.main.async {
                    self.measurementImageView.image = UIImage(named: "defaultImage")
                }
            }
        }
    }
}
