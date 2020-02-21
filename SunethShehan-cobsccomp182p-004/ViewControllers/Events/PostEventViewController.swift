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
    
    let locationManager = CLLocationManager()
    
    var imagePicker: ImagePicker!
    
    var selectedEvent: JSON?
    
    var selectedEventID :String?
    
    @IBOutlet weak var dtEventDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        if(selectedEvent != nil && !selectedEvent!.isEmpty){
            
            txtEventTitle.text = selectedEvent!["Title"].stringValue
            txtEventDescription.text = selectedEvent!["Descrption"].stringValue
            txtEventLocation.text = selectedEvent!["Location"].stringValue
            
            let imageURL = URL(string: selectedEvent!["EventImageUrl"].stringValue)
            imgEventImage.kf.setImage(with: imageURL)
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            
            dtEventDate.date = DateHandler.castStringToDate(date:selectedEvent!["EventDate"].stringValue)
            
            
            btnPostEvent.setTitle("Update Event", for: .normal)
            lblEventType.text = "Update Event"
            
        }
        
        
    }
    
    
    @IBAction func SetEventImage(_ sender: UIButton) {
        
        self.imagePicker.present(from: sender)
        
    }
    
    
    @IBAction func PostEvent(_ sender: Any) {
        
        databaseOperation()
    }
    
    func databaseOperation(){
        
        
        guard let EventTitle = txtEventTitle.text, !EventTitle.isEmpty else {
            
            Alerts.showAlert(title: "Check input",message: "Event Title cannot be empty",presentingVC: self)
            return
        }
        
        guard let EventDescription = txtEventDescription.text, !EventDescription.isEmpty else {
            
            Alerts.showAlert(title: "Check input",message: "Event Description cannot be empty",presentingVC: self)
            return
        }
        
        guard let EventLocation = txtEventLocation.text, !EventLocation.isEmpty else {
            
            Alerts.showAlert(title: "Check input",message: "Event Location cannot be empty",presentingVC: self)
            return
        }
        
        //Make this optional or alternation
        guard let image = imgEventImage.image,
            let imgData = image.jpegData(compressionQuality: 1.0) else {
                
                Alerts.showAlert(title: "Check input",message: "Event Image must be selected",presentingVC: self)
                return
        }
        
        let alert : UIAlertController
        
        if(self.selectedEvent != nil && !self.selectedEvent!.isEmpty && !self.selectedEventID!.isEmpty){
            alert = Alerts.showLoadingAlert(message: "Updating ", presentingVC: self)
        }
        else{
            alert = Alerts.showLoadingAlert(message: "Posting ", presentingVC: self)
        }
        
        let imgUrl =   FirebaseStorageClient.getImageUrl(imgData: imgData, presentingVC: self)
        
        
        let EventDate = DateHandler.castDateToString(date: self.dtEventDate.date)
        
        
        let event = Event(Title: EventTitle, Descrption: EventDescription, Location: EventLocation, EventImageUrl: imgUrl, EventDate: EventDate)
        
        //Databsae Operations
        //Edit Operation
        if(self.selectedEvent != nil && !self.selectedEvent!.isEmpty && !self.selectedEventID!.isEmpty){
            
            //delete existing image
            FirebaseStorageClient.removeExistingImageUrl(url: self.selectedEvent!["EventImageUrl"].stringValue)
            
            
            FirestoreClient.updateExistingEvent(selectedEventID: self.selectedEventID!, updatedEvent: event, viewController: self)
            
            
        }
            
            // Add Operation
        else{
            
            FirestoreClient.AddEvent(selectedEventID: self.selectedEventID!, updatedEvent: event, viewController: self)
            
            
        }
        
        alert.dismiss(animated: false, completion: nil)
        
        self.clearFields()
        
        Routes.redirectToFeed(presentingVC: self)
        
        
    }
    
    
    func clearFields(){
        
        self.txtEventTitle.text = ""
        self.txtEventDescription.text = ""
        self.txtEventLocation.text = ""
        self.imgEventImage.image = nil
        
        
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
