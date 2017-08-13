//
//  StringExtension.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 10..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

extension String
{
    func dateValue() -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMMM-dd."
        
        return dateFormatter.date(from: self) ?? Date()
    }
}
