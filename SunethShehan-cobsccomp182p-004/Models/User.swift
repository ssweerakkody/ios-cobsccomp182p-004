//
//  User.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/17/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

struct User : Codable {
    
    var FirstName: String
    var LastName: String
    var Email: String
    var MobileNo: String
    var ProfileImageUrl: String
    var FBProfileUrl: String
    var DisplayName: String
    
    init(FirstName: String, LastName: String,Email: String,MobileNo: String,ProfileImageUrl: String,FBProfileUrl: String,DisplayName: String) {
        
        self.FirstName = FirstName
         self.LastName = LastName
         self.Email = Email
         self.MobileNo = MobileNo
         self.ProfileImageUrl = ProfileImageUrl
         self.FBProfileUrl = FBProfileUrl
         self.DisplayName = DisplayName
        
    }
    
}
