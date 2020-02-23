//
//  FirestoreClient.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/20/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class FirestoreClient{
    
    static var db = Firestore.firestore()
    static var eventsCollection = db.collection("events")
    static var usersCollection = db.collection("users")
    
    static func updateExistingEvent(selectedEventID : String,updatedEvent:Event,viewController:UIViewController){
        
        let eventDoc = eventsCollection.document(selectedEventID)
        
        eventDoc.updateData(
            [
                "Title":updatedEvent.Title,
                "Descrption":updatedEvent.Descrption,
                "Location":updatedEvent.Location,
                "EventImageUrl":updatedEvent.EventImageUrl,
                "EventDate":updatedEvent.EventDate
            ]
        ) { err in
            if let err = err {
                Alerts.showAlert(title: "Eror", message: "Error uploading data: \(err.localizedDescription)", presentingVC: viewController)
                return
            }
            
            
        }
        
    }
    
    static func addEvent(newEvent:Event,viewController:UIViewController){
        
        
        let eventDoc = eventsCollection.document()
        
        let docData = try! FirestoreEncoder().encode(newEvent)
        
        eventDoc.setData(docData) { err in
            if let err = err {
                Alerts.showAlert(title: "Eror", message: "Error uploading data: \(err.localizedDescription)", presentingVC: viewController)
                return
            }
            
            
        }
        
    }
    
    static func updateAttendees(selectedEventID:String)
    {
        let eventDoc = eventsCollection.document(selectedEventID)
        
        eventDoc.getDocument { (document, error) in
            if(error == nil){
                
                
                var udpatedEvent = try! FirestoreDecoder().decode(Event.self, from: document!.data()!)
                var attendeesList = document!.get("Attendees") as! [String]
                attendeesList.append(UserDefaults.standard.string(forKey: "UserID") as Any as! String)
                
                udpatedEvent.Attendees = attendeesList
                udpatedEvent.AttendeesCount = udpatedEvent.AttendeesCount + 1
                
                eventDoc.updateData(["Attendees":attendeesList,"AttendeesCount":udpatedEvent.AttendeesCount]){ err in
                    if let err = err {
                        //Alerts.showAlert(title: "Eror", message: "Error uploading data: \(err.localizedDescription)", presentingVC: viewController)
                        print(err.localizedDescription)
                        return
                    }
                    
                    
                }
                
            }
        }
        
        
    }
    
    static func getAllEvents(completion:@escaping ([Event],[String])->()){
        
       var events = [Event]()
       var eventIDs = [String]()
        
       eventsCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    eventIDs.append(document.documentID)
                    
                    let event = try! FirestoreDecoder().decode(Event.self, from: document.data())
                    
                    events.append(event)
                    
                }
                
                completion(events,eventIDs)
                
            }
        
        }
        
    }
    
    
    static func addUser(newUser:User,viewController:UIViewController,uID:String,completion:@escaping (DocumentReference,Error?)->()){
        
        
        let userDoc = usersCollection.document(uID)
        
        let docData = try! FirestoreEncoder().encode(newUser)
        
        userDoc.setData(docData) { err in
            if let err = err {
                Alerts.showAlert(title: "Eror", message: "Error uploading data: \(err.localizedDescription)", presentingVC: viewController)
                return
            }
            
            completion(userDoc,err)
            
        }
        
        
    }
    
    
    
}
