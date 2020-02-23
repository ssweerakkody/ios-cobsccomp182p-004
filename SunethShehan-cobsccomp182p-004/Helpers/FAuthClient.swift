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
                Alerts.showAlert(title: "Eror",message: (error?.localizedDescription)!,presentingVC: presentingVC)
                
            }
            
        }
        
    }
    
}
