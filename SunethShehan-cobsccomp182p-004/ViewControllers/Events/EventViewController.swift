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
    
    
    var event: Event?
    
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
        
        lblEventTitle.text = event?.Title
        lblEventDescription.text = event?.Descrption
        lblEventLocation.text = event?.Location
        lblDate.text = event?.EventDate
        lblAttendeesC.text = String(event!.AttendeesCount)
        
        let imageURL = URL(string: event!.EventImageUrl)
        imgEventImage.kf.setImage(with: imageURL)
        
        let avatarURL = URL(string: event!.UserProfileURL)
        imgUserAvatar.kf.setImage(with: avatarURL)
        lblCreatedBy.text = event?.UserDisplayName
        
        if(Auth.auth().currentUser != nil && event!.Attendees.contains(Auth.auth().currentUser!.uid))
        {
            btnAttend.setTitle("Going",for: .normal)
            btnAttend.isUserInteractionEnabled = false
        }
        else{
            btnAttend.isUserInteractionEnabled = false
        }
        
    }
    
    func addFormStyles() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backimage.jpg")!)
        
        self.imgUserAvatar.layer.cornerRadius = self.imgUserAvatar.bounds.height / 2
        self.imgUserAvatar.clipsToBounds = true
        
        
        btnAttend.backgroundColor = .clear
        btnAttend.layer.cornerRadius = 5
        btnAttend.layer.borderWidth = 1
        btnAttend.layer.borderColor = UIColor.black.cgColor
    }
    
}
