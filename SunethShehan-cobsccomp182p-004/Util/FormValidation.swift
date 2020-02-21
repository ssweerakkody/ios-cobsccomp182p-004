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
    
}
