//
//  DateExtension.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation

extension Date
{
    func readableFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM dd."
        
        return dateFormatter.string(from: self)
    }
}
