//
//  Event.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/17/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import Firebase

struct Event : Codable {
    
    let Title: String
    let Descrption: String
    let Location: String
    let EventImageUrl: String
    let CreatedBy: User
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
