//
//  LoginViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/6/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import CodableFirebase

class LoginViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnLoginAsGuest: UIButton!
    
    
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (Auth.auth().currentUser) != nil {
            
            CurrentUser.setUserDefaults(userID: (Auth.auth().currentUser?.uid)!, completion: { response in
                
                if(response){
                    Routes.redirectToFeed(presentingVC: self)
                }
                
                
            })
            
        }
        
        addFormStyles()
        
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
        
        txtEmail.text = "sachith@mail.com"
        txtPassword.text = "456789"
        
        signInUser(email: txtEmail.text!, password: txtPassword.text!)
        
        
    }
    @IBAction func ForgetPassword(_ sender: Any) {
        
        if(FormValidation.isValidField(textField: txtEmail, textFiledName: "Email", presentingVC: self) &&
            FormValidation.isValidEmail(txtEmail.text!, presentingVC: self))
        {
            Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { error in
                if error == nil{
                    
                    Alerts.showAlert(title: "Information", message: "We have reset your password. Please check your email !", presentingVC: self)
                }
                else{
                    Alerts.showAlert(title: "Error",message: "\(error!.localizedDescription)",presentingVC: self)
                }
            }
        }
        
        
        
    }
    
    @IBAction func LoginAsGuest(_ sender: Any) {
        
        
        Routes.redirectToGuest(presentingVC: self)
        
    }
    
    func signInUser(email:String , password :String){
        
        if(self.validateInputs()){
            
            FAuthClient.signInUser(email: email, password: password, presentingVC: self) { (user) in
                if(user != nil)
                {
                    let domain = Bundle.main.bundleIdentifier!
                    
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    
                    CurrentUser.setUserDefaults(userID: (user?.user.uid)!, completion: { response in
                        
                        if(response){
                               Routes.redirectToFeed(presentingVC: self)
                        }
                        
                        
                    })
                    
                 
                }
            }
            
        }
        
    }
    
    
    func addFormStyles()
    {
        txtEmail.toStyledTextField()
        txtPassword.toStyledTextField()
        
        btnSignIn.toRoundButtonEdges()
        btnSignIn.colorButtonBackground()
        
        btnSignUp.toRoundButtonEdges()
        btnSignUp.colorButtonBackground()
        
        btnLoginAsGuest.toRoundButtonEdges()
        btnLoginAsGuest.colorButtonBackground()
        
        imgLogo.toRoundEdges()
        
        self.setBackgroundImage()
        
    }
    
    
    func validateInputs()->Bool{
        
        if(!FormValidation.isValidField(textField: txtEmail, textFiledName: "Email", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidEmail(txtEmail.text!, presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtPassword, textFiledName: "Password", presentingVC: self))
        {
            return false
        }
        
        
        return true
    }
    
}
