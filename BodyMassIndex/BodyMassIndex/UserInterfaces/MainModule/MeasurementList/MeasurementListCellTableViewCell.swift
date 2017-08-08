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
    }
    
}
