//
//  FirebaseService.swift
//  BodyMassIndex
//
//  Created by Adrian Juhasz on 2017. 08. 08..
//  Copyright © 2017. TestCompany. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore

class FirebaseService: NSObject {
    
    
    static func signIn(completion: @escaping (Bool, User)->Void) {
        
        guard let accessToken = AccessToken.current else {
            print("Failed to get access token")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            
            guard let userProfile = user else {
                return
            }
            
            completion(true, userProfile)
        })
    }
    
    static func logout() {
        
        do {
            
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteProfileMeasurements( completion: @escaping (_ success: Bool) -> Void) {
        
        let ref = Database.database().reference()

        let userID = Auth.auth().currentUser?.uid ?? ""
        
        let measurementsNewChild = ref.child("users").child("\(userID)").child("measurements")
        
        measurementsNewChild.setValue(nil) { (error, databaseRef) in
            
            completion(error == nil)
        }
    }
    
    static func deleteProfile(completion: @escaping (_ success: Bool) -> Void) {
        
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            
            completion(error == nil)
        }
    }
    
    static func addMeasurement(measurement: Measurement, completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        let measurementsNewChild = ref.child("users").child("\(userID)").child("measurements").childByAutoId()
        
        let measurement = ["userID": userID, "date": measurement.date.readableFormat(), "weight": "\(measurement.weight)"] as [String : Any]
        measurementsNewChild.updateChildValues(measurement) { (error, databaseRef) in
            
            completion(error == nil)
            
        }
    }
    
    static func measurements(completion: @escaping (_ isSuccess: Bool, _ measurements: [Measurement]) -> Void) {
        
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        ref.child("users").child("\(userID)").child("measurements").queryOrdered(byChild: "userID").queryEqual(toValue: userID).observe(.value, with: { (snapshot) in
            
            var measurements = Array<Measurement>()
            
            for item in snapshot.children {
                
                if let itemSnapshot = item as? DataSnapshot, let dictionary = itemSnapshot.value as? Dictionary<String, Any> {
                    
                    let measurement = Measurement(dictionary: dictionary)
                    
                    measurements.append(measurement)
                }
            }
            
            completion(true, measurements)
            
        }) { (error) in
            
            completion(false, [])
        }
    }

}


