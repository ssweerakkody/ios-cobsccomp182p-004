//
//  EventsTableViewCell.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/9/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgEvent: UIImageView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var lblCreatedBy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgUserAvatar.layer.masksToBounds = true
        imgUserAvatar.layer.cornerRadius = imgUserAvatar.bounds.width / 2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

