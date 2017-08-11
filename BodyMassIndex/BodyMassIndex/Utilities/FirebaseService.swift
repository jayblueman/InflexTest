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
    
    static func retrieveProfile(completion: @escaping (_ success: Bool, _ profile: Profile?) -> Void) {
        
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        ref.child("users").child("\(userID)").child("data").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? Dictionary<String, Any> {
                
                let dob = dictionary["dob"] as? String ?? ""
                let height = Double(dictionary["height"] as? String ?? "1.00") ?? 1.00
                let isMale = ((dictionary["isMale"] as? String ?? "1") == "1")
                let name = dictionary["name"] as? String ?? ""
                let weight = Int(dictionary["weight"] as? String ?? "0") ?? 0
                
                //TODO
                let profilePicture = dictionary["profilePicture"] as? String ?? ""
                
                let profile = Profile(name: name, isMale: isMale, birthDate: dob, weight: weight, profilePicture: "", height: height)
                
                completion(true, profile)
            } else {
                completion(true, nil)
            }
        }) { (error) in
            
            completion(false, nil)
        }
        
    }
    
    static func updateProfileData(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profile = ProfileManager.shared.profile else {
            completion(false)
            return
        }
        
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        let measurementsNewChild = ref.child("users").child("\(userID)").child("data")
        
        let profileData = profile.dictionary()
        
        measurementsNewChild.updateChildValues(profileData) { (error, databaseRef) in
            
            completion(error == nil)
        }
    }
    
    static func deleteProfileMeasurements( completion: @escaping (_ success: Bool) -> Void) {
        
        let ref = Database.database().reference()

        let userID = Auth.auth().currentUser?.uid ?? ""
        
        let measurementsNewChild = ref.child("users").child("\(userID)")
        
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
        
        let measurement = ["userID": userID, "date": measurement.date.readableFormat(), "weight": "\(measurement.weight)", "identifier" : measurementsNewChild.key] as [String : Any]
        measurementsNewChild.updateChildValues(measurement) { (error, databaseRef) in
            
            completion(error == nil)
            
        }
    }
    
    static func measurements(completion: @escaping (_ isSuccess: Bool, _ measurements: [Measurement]) -> Void) {
        
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        ref.child("users").child("\(userID)").child("measurements").queryOrdered(byChild: "userID").queryEqual(toValue: userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    
    static func delete(measurement: Measurement, completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        let ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        let measurementsNewChild = ref.child("users").child("\(userID)").child("measurements").child(measurement.identifier)
        
        measurementsNewChild.setValue(nil) { (error, databaseRef) in
            
            completion(error == nil)
        }
    }

}


