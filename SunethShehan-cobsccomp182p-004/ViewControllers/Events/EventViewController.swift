//
//  EventViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/10/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import Firebase

class EventViewController: UIViewController {
    
    @IBOutlet weak var imgEventImage: UIImageView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    
    @IBOutlet weak var lblEventDescription: UILabel!
    
    @IBOutlet weak var lblEventLocation: UILabel!
    
    @IBOutlet weak var imgUserAvatar: UIImageView!
    
    @IBOutlet weak var lblCreatedBy: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    
    @IBOutlet weak var btnAttend: UIButton!
    
    @IBOutlet weak var lblAttendeesC: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var lblDocID: UILabel!
    
   
    
    var selectedEvent: Event?
    var selectedEventID :String?
    
    var userID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFormStyles()
        setupView()
        
    }
    
    
    
    @IBAction func AttendEvent(_ sender: Any) {
        
        if(!Reach.isConnectedToInternet(viewController: self))
        {
            return
        }
        
        
        FirestoreClient.updateAttendees(selectedEventID: lblDocID.text!)
        lblAttendeesC.text  = String(Int(lblAttendeesC.text!)!+1)
        btnAttend.setTitle("Going", for: .normal)
        btnAttend.isUserInteractionEnabled = false
        
    }
    
    func setupView(){
        
        if(!Reach.isConnectedToInternet(viewController: self))
        {
            return
        }
        
        
        if(!selectedEventID!.isEmpty){
            FirestoreClient.getEvent(selectedEventID: selectedEventID!) { (event) in

                self.lblEventTitle.text = event.Title
                self.lblEventDescription.text = event.Descrption
                self.lblEventLocation.text = event.Location
                self.lblDate.text = event.EventDate
                self.lblAttendeesC.text = String(event.AttendeesCount)

                let imageURL = URL(string: event.EventImageUrl)
                self.imgEventImage.kf.setImage(with: imageURL)

                let avatarURL = URL(string: event.UserProfileURL)
                self.imgUserAvatar.kf.setImage(with: avatarURL)
                self.lblCreatedBy.text = event.UserDisplayName

                let overlay = UIButton(frame: self.imgUserAvatar.bounds)
                self.imgUserAvatar.isUserInteractionEnabled = true
                overlay.addTarget(self, action: #selector(self.imgUserAvatarTapped), for: .touchUpInside)
                self.imgUserAvatar.addSubview(overlay)
                
                self.userID = event.CreatedBy
                
            }
        }
    }
    
    func addFormStyles() {
        
        self.setBackgroundImage()
        
        self.imgUserAvatar.toRoundedImage()

        self.imgUserAvatar.addThinWhiteBorder()
        
    }
    
    @IBAction func imgUserAvatarTapped(sender: UIButton) {
        
        Routes.showUserProfile(userID: self.userID!, presentingVC: self)
        
    }
    
    @IBAction func ShowComments(_ sender: Any) {
        
 
        Routes.showComments(selectedEventID: selectedEventID!, presentingVC: self)
        
    }
    
}

