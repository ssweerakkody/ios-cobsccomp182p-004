//
//  PostEventViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/9/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import CodableFirebase
import CoreLocation

class PostEventViewController: UIViewController ,CLLocationManagerDelegate{
    
    @IBOutlet weak var imgEventImage: UIImageView!
    
    @IBOutlet weak var txtEventTitle: UITextField!
    
    @IBOutlet weak var txtEventDescription: UITextField!
    
    @IBOutlet weak var txtEventLocation: UITextField!
    
    @IBOutlet weak var lblEventType: UILabel!
    
    @IBOutlet weak var btnPostEvent: UIButton!
    
    
    
    @IBOutlet weak var btnViewEvent: UIButton!
    
    let locationManager = CLLocationManager()
    
    var imagePicker: ImagePicker!
    
    var selectedEvent: Event?
    
    var selectedEventID :String?
    
    @IBOutlet weak var dtEventDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupView()
        addStylesToView()
        
        
    }
    
    
    @IBAction func SetEventImage(_ sender: UIButton) {
        
        self.imagePicker.present(from: sender)
        
    }
    
    
    @IBAction func PostEvent(_ sender: Any) {
        
        proceedData()
    }
    
    func proceedData(){
        
        
        if(self.validateInputs()){
            
            guard let image = imgEventImage.image,
                let imgData = image.jpegData(compressionQuality: 1.0) else {
                    
                    Alerts.showAlert(title: "Check input",message: "Event Image must be selected",presentingVC: self)
                    return
            }
            
            let alert : UIAlertController
            
            if(self.selectedEvent != nil &&  !self.selectedEventID!.isEmpty){
                alert = Alerts.showLoadingAlert(message: "Updating ", presentingVC: self)
            }
            else{
                alert = Alerts.showLoadingAlert(message: "Posting ", presentingVC: self)
            }
            
            FirebaseStorageClient.getEventImageUrl(imgData: imgData, presentingVC: self,completion: { imgUrl in
                
                let EventDate = DateHandler.castDateToString(date: self.dtEventDate.date)
                
                
                let event = Event(Title: self.txtEventTitle.text!, Descrption: self.txtEventDescription.text!, Location: self.txtEventLocation.text!, EventImageUrl: imgUrl, EventDate: EventDate,AttendeesCount: 0, Attendees:  [])
                
                //Databsae Operations
                //Edit Operation
                if(self.selectedEvent != nil && !self.selectedEventID!.isEmpty){
                    
                    //delete existing image
                    FirebaseStorageClient.removeExistingImageUrl(url: self.selectedEvent!.EventImageUrl)
                    
                    
                    FirestoreClient.updateExistingEvent(selectedEventID: self.selectedEventID!, updatedEvent: event, viewController: self)
                    
                    
                }
                    
                    // Add Operation
                else{
                    
                    FirestoreClient.addEvent(newEvent: event, viewController: self)
                    
                    
                }
                
                alert.dismiss(animated: false, completion: nil)
                
                self.clearFields()
                
                Routes.redirectToFeed(presentingVC: self)
                
                
            })
            
            
        }
        
        
    }
    
    
    func clearFields(){
        
        self.txtEventTitle.text = ""
        self.txtEventDescription.text = ""
        self.txtEventLocation.text = ""
        self.imgEventImage.image = nil
        
        
    }
    
    func validateInputs()->Bool{
        
        if(!FormValidation.isValidField(textField: txtEventTitle, textFiledName: "Event Title", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtEventDescription, textFiledName: "Event Description", presentingVC: self))
        {
            return false
        }
        if(!FormValidation.isValidField(textField: txtEventLocation, textFiledName: "Event Description", presentingVC: self))
        {
            return false
        }
        
        return true
        
    }
    
    
    func setupView(){
        
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        
        if(selectedEvent != nil){
            
            txtEventTitle.text = selectedEvent?.Title
            txtEventDescription.text = selectedEvent?.Descrption
            txtEventLocation.text = selectedEvent?.Location
            
            let imageURL = URL(string: selectedEvent!.EventImageUrl)
            imgEventImage.kf.setImage(with: imageURL)
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            
            dtEventDate.date = DateHandler.castStringToDate(date:selectedEvent!.EventDate)
            
            
            btnPostEvent.setTitle("Update Event", for: .normal)
            lblEventType.text = "Update Event"
            
            btnViewEvent.isHidden = false
            
        }
        
    }
    
    func addStylesToView(){
        self.setBackgroundImage()
        
    }
    

    
    @IBAction func ViewEvent(_ sender: Any) {
        
        
        Routes.authourViewEvent(selectedEvent: self.selectedEvent!, selectedEventID: self.selectedEventID!, presentingVC: self)
        
    }
    
    
    @IBAction func GetCurrentLocation(_ sender: Any) {
        
        txtEventLocation.placeholder = "Fetching..."
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : "" as String
            //let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : "" as String
            //let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            txtEventLocation.placeholder = "Event Location"
            txtEventLocation.text = "\(locality!) \(administrativeArea!)"
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
