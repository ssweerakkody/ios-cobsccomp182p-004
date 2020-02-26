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
    
    @IBOutlet weak var btnAttend: UIButton!
    
    
    @IBOutlet weak var lblEventDate: UILabel!
    
    
    @IBOutlet weak var lblAttendeesCount: UILabel!
    
    @IBOutlet weak var lblDocID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addStylesToCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    @IBAction func AttendEvent(_ sender: Any) {
        
        FirestoreClient.updateAttendees(selectedEventID: lblDocID.text!)
        lblAttendeesCount.text  = String(Int(lblAttendeesCount.text!)!+1)
        btnAttend.setTitle("Going", for: .normal)
        btnAttend.isUserInteractionEnabled = false
    }
    
    func addStylesToCell(){
        imgUserAvatar.layer.masksToBounds = true
        imgUserAvatar.layer.cornerRadius = imgUserAvatar.bounds.width / 2
        
        btnAttend.backgroundColor = .clear
        btnAttend.layer.cornerRadius = 5
        btnAttend.layer.borderWidth = 1
        btnAttend.layer.borderColor = UIColor.black.cgColor
        
        imgEvent.toRoundEdges()
        
    }
}

