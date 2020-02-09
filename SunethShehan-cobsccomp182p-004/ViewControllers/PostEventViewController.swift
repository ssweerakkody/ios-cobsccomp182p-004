//
//  PostEventViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/9/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase

class PostEventViewController: UIViewController {
    
    @IBOutlet weak var imgEventImage: UIImageView!
    
    @IBOutlet weak var txtEventTitle: UITextField!
    
    @IBOutlet weak var txtEventDescription: UITextField!
    
    @IBOutlet weak var txtEventLocation: UITextField!
    
    
     var ref: DatabaseReference!
    
     var imagePicker: ImagePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func SetEventImage(_ sender: UIButton) {
        
           self.imagePicker.present(from: sender)
        
    }
    
    
    @IBAction func PostEvent(_ sender: Any) {
        
        databaseOperation()
    }
    
    func databaseOperation(){
        
        ref = Database.database().reference()
        
        guard let EventTitle = txtEventTitle.text, !EventTitle.isEmpty else {
            
            showAlert(title: "Check input",message: "Event Title cannot be empty")
            return
        }
        
        guard let EventDescription = txtEventDescription.text, !EventDescription.isEmpty else {
            
            showAlert(title: "Check input",message: "Event Description cannot be empty")
            return
        }

        guard let EventLocation = txtEventLocation.text, !EventLocation.isEmpty else {
            
            showAlert(title: "Check input",message: "Event Location cannot be empty")
            return
        }
        
        //Make this optional or alternation
        guard let image = imgEventImage.image,
            let imgData = image.jpegData(compressionQuality: 1.0) else {
                
                showAlert(title: "Check input",message: "Event Image must be selected")
                return
        }
        
        let alert = UIAlertController(title: nil, message: "Posting ", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        let imageName = UUID().uuidString
        
        let reference = Storage.storage().reference().child("EventImages").child(imageName)
        
        
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
                
                
                let dbRef = Database.database().reference().child("Events").childByAutoId()
                
                
                let data = [
                    "Title" : EventTitle,
                    "Descrption" : EventDescription,
                    "Location":EventLocation,
                    "EventImageUrl": imgUrl
                ]
                
                dbRef.setValue(data, withCompletionBlock: { ( err , dbRef) in
                    if let err = err {
                        self.showAlert(title: "Eror",message: "Error uploading data: \(err.localizedDescription)")
                        return
                    }
                    alert.dismiss(animated: false, completion: nil)
                    
                   
                    self.clearFields()
                    
                    let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventNavigation") as! UITabBarController
                    tabVC.selectedIndex = 1
                    
                    self.present(tabVC, animated: true, completion: nil)
                    self.loadView()
                    self.view.setNeedsLayout()
                    
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
    
    func clearFields(){
        
        self.txtEventTitle.text = ""
        self.txtEventDescription.text = ""
        self.txtEventLocation.text = ""
        self.imgEventImage.image = nil
        
        
    }
    
    
}
