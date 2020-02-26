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
        
        
        FirestoreClient.updateAttendees(selectedEventID: lblDocID.text!)
        lblAttendeesC.text  = String(Int(lblAttendeesC.text!)!+1)
        btnAttend.setTitle("Going", for: .normal)
        btnAttend.isUserInteractionEnabled = false
        
    }
    
    func setupView(){
        
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
                
                self.imgUserAvatar.addWhiteBorder()
                
//                if(Auth.auth().currentUser != nil && event.Attendees.contains(Auth.auth().currentUser!.uid))
//                {
//                    self.btnAttend.setTitle("Going",for: .normal)
//                    self.btnAttend.isUserInteractionEnabled = false
//                }
//                else{
//                    self.btnAttend.isUserInteractionEnabled = false
//                }


            }
        }
        
        
//        self.lblEventTitle.text = selectedEvent?.Title
//        self.lblEventDescription.text = selectedEvent?.Descrption
//        self.lblEventLocation.text = selectedEvent?.Location
//        self.lblDate.text = selectedEvent?.EventDate
//        self.lblAttendeesC.text = String(selectedEvent!.AttendeesCount)
//
//        let imageURL = URL(string: selectedEvent!.EventImageUrl)
//                        self.imgEventImage.kf.setImage(with: imageURL)
//
//        let avatarURL = URL(string: selectedEvent!.UserProfileURL)
//                        self.imgUserAvatar.kf.setImage(with: avatarURL)
//        self.lblCreatedBy.text = selectedEvent?.UserDisplayName
//
//        if(Auth.auth().currentUser != nil && selectedEvent!.Attendees.contains(Auth.auth().currentUser!.uid))
//                        {
//                            self.btnAttend.setTitle("Going",for: .normal)
//                            self.btnAttend.isUserInteractionEnabled = false
//                        }
//                        else{
//                            self.btnAttend.isUserInteractionEnabled = false
//                        }
//
        
        
    }
    
    func addFormStyles() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backimage.jpg")!)
        
        self.imgUserAvatar.layer.cornerRadius = self.imgUserAvatar.bounds.height / 2
        self.imgUserAvatar.clipsToBounds = true
        
        
//        btnAttend.backgroundColor = .clear
//        btnAttend.layer.cornerRadius = 5
//        btnAttend.layer.borderWidth = 1
//        btnAttend.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func imgUserAvatarTapped(sender: UIButton) {
        
        
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileView") as! ProfileViewController
        
                vc.userID = self.userID
        
                navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

