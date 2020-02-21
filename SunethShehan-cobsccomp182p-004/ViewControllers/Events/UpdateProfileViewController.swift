//
//  UpdateProfileViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/16/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class UpdateProfileViewController: UIViewController{
    
    
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
    
    @IBAction func SaveUserInfo(_ sender: Any) {
        
        databaseOperation()
        
    }
    
    var ref: DatabaseReference!
    
    @IBAction func Logout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        let domain = Bundle.main.bundleIdentifier!
        
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        let vc = UIStoryboard(name: "UserAuthentication", bundle: nil).instantiateViewController(withIdentifier: "RootUserNavigation")
        self.present(vc, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(authenticationWithTouchID())
        {
            imgProPicture.layer.masksToBounds = true
            imgProPicture.layer.cornerRadius = imgProPicture.bounds.width / 2
            
            self.imagePicker = ImagePicker(presentationController: self, delegate: self)
            
            let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
            view.addGestureRecognizer(tap)
            
            
            if Auth.auth().currentUser != nil {
                
                txtFName.text  = UserDefaults.standard.string(forKey: "FirstName")
                txtLName.text  = UserDefaults.standard.string(forKey: "LastName")
                txtEmail.text  = UserDefaults.standard.string(forKey: "Email")
                txtDisplayName.text = UserDefaults.standard.string(forKey: "DisplayName")
                txtMobileNo.text  = UserDefaults.standard.string(forKey: "MobileNo")
                txtFBProfileUrl.text  = UserDefaults.standard.string(forKey: "FBProfileUrl")
                let imageURL = URL(string: UserDefaults.standard.string(forKey: "ProfileImageUrl")!)
                imgProPicture.kf.setImage(with: imageURL)
                
                
            }
            
            
        }
        
        
    }
    
    @IBAction func SetProfilePicture(_ sender: UIButton) {
        
        self.imagePicker.present(from: sender)
        
    }
    
    func databaseOperation(){
        ref = Database.database().reference()
        
        // use update values with firebase
        
//        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
//
//            if((error==nil)){
//
//                //self.showAlert(title: "Success", message: "User Registration Success !")
//                self.userID = (authResult?.user.uid)!
//
//
//            }
//            else{
//
//                self.showAlert(title: "Error", message: (error?.localizedDescription)!)
//                return
//
//            }
//
//        }
        
        guard let FirstName = txtFName.text, !FirstName.isEmpty else {
            
            showAlert(title: "Check input",message: "First Name cannot be empty")
            return
        }
        
        guard let LastName = txtLName.text, !LastName.isEmpty else {
            
            showAlert(title: "Check input",message: "Last Name cannot be empty")
            return
        }
        
        guard let Email = txtEmail.text, !Email.isEmpty else {
            
            showAlert(title: "Check input",message: "Email cannot be empty")
            return
        }
        
        guard let DisplayName = txtDisplayName.text, !Email.isEmpty else {
            
            showAlert(title: "Check input",message: "Display Name cannot be empty")
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
                
                
                let dbRef = Database.database().reference().child("Users").child(UserDefaults.standard.string(forKey: "UserDocID")!)
                
                let data = [
                    "FirstName" : FirstName,
                    "LastName" : LastName,
                    "Email":Email,
                    "MobileNo": MobileNo,
                    "ProfileImageUrl" : imgUrl,
                    "FBProfileUrl":FBProfileUrl,
                    "UserID":UserDefaults.standard.string(forKey: "UserID"),
                    "DisplayName": DisplayName
                ]
                
                dbRef.setValue(data, withCompletionBlock: { ( err , dbRef) in
                    if let err = err {
                        self.showAlert(title: "Eror",message: "Error uploading data: \(err.localizedDescription)")
                        return
                    }
                    
                    alert.dismiss(animated: false, completion: nil)
                    
                })
                
                
            }
        }
      
    }
    func showAlert(title:String,message:String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func authenticationWithTouchID()->Bool {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
        
        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                       return true
                    }
                    
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                    
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return false
            }
            print(error)
        }
        return true
    }
    
}



