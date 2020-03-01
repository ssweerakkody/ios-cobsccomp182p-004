//
//  CurrentUser.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/23/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import Foundation

class CurrentUser{
    
   static var UserDetails : User?
    
    static func setUserDefaults(userID:String,completion:@escaping (Bool) ->()){
        
        FirestoreClient.getApplicationUser(uID: userID) { document in
            
            if(document != nil) {
                
                UserDefaults.standard.set(document!.get("DisplayName") as! String, forKey: "DisplayName")
                UserDefaults.standard.set(document!.get("Email") as! String, forKey: "Email")
                UserDefaults.standard.set(document!.get("FBProfileUrl") as! String, forKey: "FBProfileUrl")
                UserDefaults.standard.set(document!.get("FirstName") as! String, forKey: "FirstName")
                UserDefaults.standard.set(document!.get("LastName") as! String, forKey: "LastName")
                UserDefaults.standard.set(document!.get("MobileNo") as! String, forKey: "MobileNo")
                UserDefaults.standard.set(document!.get("ProfileImageUrl") as! String, forKey: "ProfileImageUrl")
                UserDefaults.standard.set(userID, forKey: "UserID")
                
                
                UserDefaults.standard.synchronize()
                
                completion(true)
            }
            
        }
        
    }
}
