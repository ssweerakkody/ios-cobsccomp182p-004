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
    
     var event: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgUserAvatar.layer.cornerRadius = self.imgUserAvatar.bounds.height / 2
        self.imgUserAvatar.clipsToBounds = true
        
        lblEventTitle.text = event!["Title"].stringValue
        lblEventDescription.text = event!["Descrption"].stringValue
        lblEventLocation.text = event!["Location"].stringValue
        
        let imageURL = URL(string: event!["EventImageUrl"].stringValue)
        imgEventImage.kf.setImage(with: imageURL)
        
        let avatarURL = URL(string: event!["UserProfileURL"].stringValue)
        imgUserAvatar.kf.setImage(with: avatarURL)
        lblCreatedBy.text = event!["UserDisplayName"].stringValue
        

        // Do any additional setup after loading the view.
        
    }
}
