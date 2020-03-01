//
//  FAuthClient.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/23/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase

class FAuthClient {
    
    static var AuthRef = Auth.auth()
    
    static func createNewUser(email:String,password:String,presentingVC:UIViewController,completion:@escaping (String)->()){
        
        AuthRef.createUser(withEmail: email, password: password) { (AuthDataResult, error) in
            
            if((error==nil)){
                completion((AuthDataResult?.user.uid)!)
            }
            else{
                Alerts.showAlert(title: "Error",message: (error?.localizedDescription)!,presentingVC: presentingVC)
                
            }
            
        }
        
    }
    
    static func signInUser(email:String,password:String,presentingVC:UIViewController,completion:@escaping (AuthDataResult?)->()){
        
        AuthRef.signIn(withEmail: email, password: password) { (user, error) in
            if(error != nil)
            {
                Alerts.showAlert(title: "Error",message: (error?.localizedDescription)!,presentingVC: presentingVC)
                completion(nil)
                return
            }
            else if(error == nil && user != nil)
            {
                completion(user)
            }
        }
    }
    
    
}
