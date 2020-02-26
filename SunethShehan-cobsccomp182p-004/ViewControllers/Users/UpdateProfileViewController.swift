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
        
      addStylesToView()
        
        if(authenticationWithTouchID())
        {
            
            
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
        
        
        if(validateInputs())
        {
            FAuthClient.createNewUser(email: txtEmail.text!, password: txtPassword.text!, presentingVC: self) { uid in
                
                if(!uid.isEmpty)
                {
                    //Make this optional or alternation
                    guard let image = self.imgProPicture.image,
                        let imgData = image.jpegData(compressionQuality: 1.0) else {
                            
                            //                        showAlert(title: "Check input",message: "Profile Picture must be selected")
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
                        
                        FirebaseStorageClient.removeExistingImageUrl(url: UserDefaults.standard.string(forKey: "ProfileImageUrl")!)
                        
                        FirestoreClient.updateUser( updatedUser: user, viewController: self,uID: uid, completion: {  (userDoc,err) in
                            
                            alert.dismiss(animated: false, completion: nil)
                            
                            
                            UserDefaults.standard.set(self.txtDisplayName.text!, forKey: "DisplayName")
                            UserDefaults.standard.set(self.txtEmail.text!, forKey: "Email")
                            UserDefaults.standard.set(self.txtFBProfileUrl.text!, forKey: "FBProfileUrl")
                            UserDefaults.standard.set(self.txtFName.text!, forKey: "FirstName")
                            UserDefaults.standard.set(self.txtLName.text!, forKey: "LastName")
                            UserDefaults.standard.set(self.txtMobileNo.text!, forKey: "MobileNo")
                            UserDefaults.standard.set(imgUrl, forKey: "ProfileImageUrl")
                            UserDefaults.standard.set(uid, forKey: "UserID")
                            
                            UserDefaults.standard.synchronize()
                            
                            
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
        
        return true
        
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
    
    func addStylesToView(){
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backimage.jpg")!)
       
        imgProPicture.toRoundedImage()
        imgProPicture.addWhiteBorder()
        
    }
    
    
}



