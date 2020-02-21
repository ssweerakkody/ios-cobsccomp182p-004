//
//  Event.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/17/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import Firebase
import CodableFirebase

struct Event : Codable{
    
    let Title: String
    let Descrption: String
    let Location: String
    let EventImageUrl: String
    let CreatedBy: String
    let UserDisplayName: String
    let UserProfileURL: String
    let EventDate: String
    
    
    init(Title:String,Descrption:String,Location:String,EventImageUrl:String,EventDate:String) {
        self.Title = Title
        self.Descrption = Descrption
        self.Location = Location
        self.EventImageUrl = EventImageUrl
        self.CreatedBy = UserDefaults.standard.string(forKey: "UserID") as Any as! String
        self.UserDisplayName = UserDefaults.standard.string(forKey: "DisplayName") as Any as! String
        self.UserProfileURL = UserDefaults.standard.string(forKey: "ProfileImageUrl")as Any as! String
        self.EventDate = EventDate
        
    }
    
}

struct Comment : Codable {
    
    let CommentedBy:User
    let CommentValue:String
    
}

//
//let data = [
//    "Title" : EventTitle,
//    "Descrption" : EventDescription,
//    "Location":EventLocation,
//    "EventImageUrl": imgUrl,
//    "CreatedBy":UserDefaults.standard.string(forKey: "UserID"),
//    "UserDisplayName":UserDefaults.standard.string(forKey: "DisplayName"),
//    "UserProfileURL":UserDefaults.standard.string(forKey: "ProfileImageUrl")
//]
