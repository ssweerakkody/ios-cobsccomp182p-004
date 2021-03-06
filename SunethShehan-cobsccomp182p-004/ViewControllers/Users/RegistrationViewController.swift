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
    
    
    @IBOutlet weak var imgProPicture: UIImageView!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDisplayName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtFBProfileUrl: UITextField!
    
    var imagePicker: ImagePicker!
    
    var userID :String = ""
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        proceedData()
        
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addStylesToRegister()
        setupView()
        
        
    }
    
    @IBAction func SetProfilePicture(_ sender: UIButton) {
        
        self.imagePicker.present(from: sender)
        
    }
    
    func proceedData(){
        
        if(!Reach.isConnectedToInternet(viewController: self))
        {
            return
        }
        
        if(validateInputs())
        {
            FAuthClient.createNewUser(email: txtEmail.text!, password: txtPassword.text!, presentingVC: self) { uid in
                
                if(!uid.isEmpty)
                {
                    //Make this optional or alternation
                    guard let image = self.imgProPicture.image,
                        let imgData = image.jpegData(compressionQuality: 1.0) else {
                            
                            return
                    }
                    
                    let alert = UIAlertController(title: nil, message: "Saving ", preferredStyle: .alert)
                    
                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                    loadingIndicator.hidesWhenStopped = true
                    loadingIndicator.style = UIActivityIndicatorView.Style.gray
                    loadingIndicator.startAnimating();
                    
                    alert.view.addSubview(loadingIndicator)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    FirebaseStorageClient.getUserImageUrl(imgData: imgData, presentingVC: self, completion: { imgUrl in
                        
                        
                        let user = User(FirstName: self.txtFName.text!, LastName: self.txtLName.text!, Email: self.txtEmail.text!, MobileNo: self.txtMobileNo.text!, ProfileImageUrl: imgUrl, FBProfileUrl: self.txtFBProfileUrl.text!, DisplayName: self.txtDisplayName.text!)
                        
                        
                        FirestoreClient.addUser(newUser: user, viewController: self,uID: uid, completion: {  (userDoc,err) in
                            
                            alert.dismiss(animated: false, completion: nil)
                            
                            //Redirect to the feed view
                            let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventNavigation") as! UITabBarController
                            tabVC.selectedIndex = 1
                            
                            UserDefaults.standard.set(self.txtDisplayName.text!, forKey: "DisplayName")
                            UserDefaults.standard.set(self.txtEmail.text!, forKey: "Email")
                            UserDefaults.standard.set(self.txtFBProfileUrl.text!, forKey: "FBProfileUrl")
                            UserDefaults.standard.set(self.txtFName.text!, forKey: "FirstName")
                            UserDefaults.standard.set(self.txtLName.text!, forKey: "LastName")
                            UserDefaults.standard.set(self.txtMobileNo.text!, forKey: "MobileNo")
                            UserDefaults.standard.set(imgUrl, forKey: "ProfileImageUrl")
                            UserDefaults.standard.set(uid, forKey: "UserID")
                            
                            UserDefaults.standard.synchronize()
                            
                            self.present(tabVC, animated: true, completion: nil)
                            self.loadView()
                            self.view.setNeedsLayout()
                            
                        })
                        
                    })
                    
                }
                
            }
        }
        
        
    }
    
    func validateInputs()->Bool{
        
        if(!FormValidation.isValidField(textField: txtFName, textFiledName: "First Name", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtLName, textFiledName: "Last Name", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtEmail, textFiledName: "Email", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidEmail(txtEmail.text!, presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtMobileNo, textFiledName: "Mobile No", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtMobileNo, textFiledName: "Mobile No", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtDisplayName, textFiledName: "Display Name", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtPassword, textFiledName: "Password", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtConfirmPassword, textFiledName: "Confirm Password", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isEqualPasswords(password: txtPassword, confirmPassword: txtConfirmPassword, presentingVC: self))
        {
            return false
        }
        
        
        return true
        
    }
    
    
        func addStylesToRegister()  {
            
           self.setBackgroundImage()
            
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    
            
            imgProPicture.layer.masksToBounds = true
            imgProPicture.layer.cornerRadius = imgProPicture.bounds.width / 2
            
    
            txtFName.toStyledTextField()
            txtLName.toStyledTextField()
            txtEmail.toStyledTextField()
            txtDisplayName.toStyledTextField()
            txtPassword.toStyledTextField()
            txtConfirmPassword.toStyledTextField()
            txtMobileNo.toStyledTextField()
            txtFBProfileUrl.toStyledTextField()
            
        }
    
    func setupView(){
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
}


