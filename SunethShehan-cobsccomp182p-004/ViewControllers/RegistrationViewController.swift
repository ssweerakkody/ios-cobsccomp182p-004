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
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtFBProfileUrl: UITextField!
    
   var imagePicker: ImagePicker!
    @IBAction func btnSignUp(_ sender: Any) {
        
        databaseOperation()
        
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addStylesToRegister()
        imgProPicture.layer.masksToBounds = true
        imgProPicture.layer.cornerRadius = imgProPicture.bounds.width / 2
        
      self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @IBAction func SetProfilePicture(_ sender: UIButton) {
        
      self.imagePicker.present(from: sender)
        
    }
    
    func databaseOperation(){
        
        ref = Database.database().reference()
        
        //create the user in authentication
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
            
            if((error==nil)){
                
                //self.showAlert(title: "Success", message: "User Registration Success !")
                
            }
            else{
                
                self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                return
                
            }
            
        }
        
        guard let FirstName = txtFName.text, !FirstName.isEmpty else {
            
            showAlert(title: "Check input",message: "FirstName cannot be empty")
            return
        }
        
        guard let LastName = txtLName.text, !LastName.isEmpty else {
            
            showAlert(title: "Check input",message: "LastName cannot be empty")
            return
        }
        
        guard let Email = txtEmail.text, !Email.isEmpty else {
            
            showAlert(title: "Check input",message: "Email cannot be empty")
            return
        }
        
        guard let Password = txtPassword.text, !Password.isEmpty else {
            
            showAlert(title: "Check input",message: "Password cannot be empty")
            return
        }
        
        guard let ConfirmPassword = txtConfirmPassword.text, !ConfirmPassword.isEmpty else {
            
            showAlert(title: "Check input",message: "Confirm Password cannot be empty")
            return
        }
        
        guard let MobileNo = txtMobileNo.text, !MobileNo.isEmpty else {
            
            showAlert(title: "Check input",message: "MobileNo cannot be empty")
            return
        }
        
        //Make this optional or alternation
        guard let image = imgProPicture.image,
            let imgData = image.jpegData(compressionQuality: 1.0) else {
                
                showAlert(title: "Check input",message: "Profile Picture must be selected")
                return
        }
        
        let FBProfileUrl = txtFBProfileUrl.text!
        
        let alert = UIAlertController(title: nil, message: "Saving ", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        let imageName = UUID().uuidString
        
        let reference = Storage.storage().reference().child("UserProfileImages").child(imageName)
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        
        reference.putData(imgData, metadata: metaData) { (meta, err) in
            if let err = err {
                alert.dismiss(animated: false, completion: nil)
                self.showAlert(title: "Eror",message: "Error uploading image: \(err.localizedDescription)")
                return
            }
            
            reference.downloadURL { (url, err) in
                if let err = err {
                    alert.dismiss(animated: false, completion: nil)
                    self.showAlert(title: "Eror",message: "Error fetching url: \(err.localizedDescription)")
                    return
                }
                
                guard let url = url else {
                    alert.dismiss(animated: false, completion: nil)
                    self.showAlert(title: "Eror",message: "Error getting url")
                    return
                }
                
                let imgUrl = url.absoluteString
                
                
                let dbRef = Database.database().reference().child("Users").childByAutoId()
                
                
                let data = [
                    "FirstName" : FirstName,
                    "LastName" : LastName,
                    "Email":Email,
                    "MobileNo": MobileNo,
                    "ProfileImageUrl" : imgUrl,
                    "FBProfileUrl":FBProfileUrl
                    ]
                
                dbRef.setValue(data, withCompletionBlock: { ( err , dbRef) in
                    if let err = err {
                        self.showAlert(title: "Eror",message: "Error uploading data: \(err.localizedDescription)")
                        return
                    }
                    alert.dismiss(animated: false, completion: nil)
                    
                    self.showAlert(title: "Success", message: "User Saved !")
                    
                    
                })
                
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



