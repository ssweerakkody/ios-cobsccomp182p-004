//
//  RegistrationViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/6/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController{
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        databaseOperation()
        
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addStylesToRegister()
        
    }
    
    
    func databaseOperation(){
        
        ref = Database.database().reference()
        
        //self.ref.child("df").child("articles") .setValue(["username": "testusername2"])
        
        self.ref.child("Users").childByAutoId().setValue(["FirstName":txtFName.text!,"LastName":txtLName.text!,"Email":txtEmail.text!,"Password":txtPassword.text!])
        
        //create the user in authentication
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
            
            if((error==nil)){
                
                self.showAlert(title: "Success", message: "User Registration Success !")
//                let vc = UIStoryboard(name:"UserAuthentication",bundle: nil).instantiateViewController(withIdentifier: "login")
//                
//                self.present(vc,animated: true,completion: nil)
                
            }
            else{
                
                self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                
            }
            
        }
        
    }
    
    
//    func addStylesToRegister()  {
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
//
//
//        txtFName.roundCorners([.topLeft,], radius: 10)
//        txtLName.roundCorners([.topRight,], radius: 10)
//        txtEmail.roundCorners([.bottomLeft,.bottomRight], radius: 10)
//        txtPassword.roundCorners([.topLeft,.topRight], radius: 10)
//        txtConfirmPassword.roundCorners([.bottomLeft,.bottomRight], radius: 10)
//        txtZipCode.roundCorners([.bottomLeft,.bottomRight,.topRight,.topLeft], radius:10)
//
//        txtFName.setLeftPaddingPoints(8)
//        txtLName.setLeftPaddingPoints(8)
//        txtEmail.setLeftPaddingPoints(8)
//        txtPassword.setLeftPaddingPoints(8)
//        txtConfirmPassword.setLeftPaddingPoints(8)
//        txtZipCode.setLeftPaddingPoints(8)
//
//
//
//        txtFName.placeholderColor(color: UIColor.white)
//        txtLName.placeholderColor(color: UIColor.white)
//        txtEmail.placeholderColor(color: UIColor.white)
//        txtPassword.placeholderColor(color: UIColor.white)
//        txtConfirmPassword.placeholderColor(color: UIColor.white)
//        txtZipCode.placeholderColor(color: UIColor.white)
//    }
    
    
    func showAlert(title:String,message:String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
}



