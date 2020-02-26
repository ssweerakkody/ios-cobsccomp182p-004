//
//  FormValidation.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/20/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit

class FormValidation{
    
    static func isValidField(textField:UITextField , textFiledName : String,presentingVC:UIViewController) -> Bool{
        
        if (textField.text!.isEmpty){
            
            Alerts.showAlert(title: "Check input",message:"\(textFiledName) cannot be empty",presentingVC: presentingVC)
            return false
            
        }
        return true
    }
    
    static func isEqualPasswords(password:UITextField , confirmPassword : UITextField,presentingVC:UIViewController) -> Bool{
        
        if (password.text != confirmPassword.text){
            
            Alerts.showAlert(title: "Check input",message:"Passwwords are not equal",presentingVC: presentingVC)
            return false
            
        }
        return true
    }
    
    static func isValidEmail(_ email: String,presentingVC :UIViewController) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if(!emailPred.evaluate(with: email))
        {
            Alerts.showAlert(title: "Check input",message:"Email is not formatted correctly !",presentingVC: presentingVC)
            return false
        }
        return true
    }
    
}
