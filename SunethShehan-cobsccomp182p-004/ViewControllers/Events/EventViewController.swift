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

class EventViewController: UIViewController {

    @IBOutlet weak var imgEventImage: UIImageView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    
    @IBOutlet weak var lblEventDescription: UILabel!
    
    @IBOutlet weak var lblEventLocation: UILabel!
    
    @IBOutlet weak var imgUserAvatar: UIImageView!
    
    @IBOutlet weak var lblCreatedBy: UILabel!
    
     var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgUserAvatar.layer.cornerRadius = self.imgUserAvatar.bounds.height / 2
        self.imgUserAvatar.clipsToBounds = true
        
        lblEventTitle.text = event?.Title
        lblEventDescription.text = event?.Descrption
        lblEventLocation.text = event?.Location
        
        let imageURL = URL(string: event!.EventImageUrl)
        imgEventImage.kf.setImage(with: imageURL)
        
        let avatarURL = URL(string: event!.UserProfileURL)
        imgUserAvatar.kf.setImage(with: avatarURL)
        lblCreatedBy.text = event?.UserDisplayName
        

        // Do any additional setup after loading the view.
        
    }
}
