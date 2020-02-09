//
//  LoginViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/6/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController ,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      Do any additional setup after loading the view.
        txtEmail.delegate = self
        txtEmail.toStyledTextField()
        txtPassword.toStyledTextField()

        btnSignIn.toRoundButtonEdges()
        
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            if error == nil{
                
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventNavigation") as! UITabBarController
                tabVC.selectedIndex = 1
                
                self.present(tabVC, animated: true, completion: nil)
                self.loadView()
                self.view.setNeedsLayout()
                
                
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func ForgetPassword(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { error in
            if error == nil{
                //self.performSegue(withIdentifier: "loginToHome", sender: self)
                
                let alertController = UIAlertController(title: "Information", message: "We have reset your password. Please check your email !", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }

        
    }
    
}
