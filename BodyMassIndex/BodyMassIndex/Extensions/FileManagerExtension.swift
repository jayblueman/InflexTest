//
//  FileManagerExtension.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 12..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import Foundation
import UIKit


extension FileManager {
    
    static func store(image: UIImage, withFilename filename: String) {
        
        if let data = UIImagePNGRepresentation(image) {
            do {
                let filepath = FileManager.filepath(forFilename: filename)
                try data.write(to: filepath)
            }
            catch {
                
                print("Image store Error")
            }
            
        }
    }
    
    static func filepath(forFilename filename: String) -> URL {
    
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filepath = documentsDirectory.appendingPathComponent("\(filename).png")
        
        return filepath
    }
    
    static func deleteFile(filename: String) {
        do {
            let filepath = FileManager.filepath(forFilename: filename)
            try FileManager().removeItem(at: filepath)
        }
        catch {
            
            print("Image delete Error")
        }
    }
}
