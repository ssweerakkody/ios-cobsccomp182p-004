//
//  GuestTableViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/21/20.
//  Copyright © 2020 Suneth. All rights reserved.
//


import UIKit
import SwiftyJSON
import Kingfisher
import Firebase
import CodableFirebase

final class GuestTableViewController: UITableViewController {
    
    
    var EventIDs = [String]()
    
    var Users = [String]()
    
    private var Events = [Event]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreClient.getAllEvents(completion: {events , eventIDs in
            self.Events = events
            self.EventIDs = eventIDs
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Events.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",for: indexPath) as! EventsTableViewCell
        
        cell.lblEventDate.text = Events[indexPath.row].EventDate
        
        cell.lblCreatedBy.text =  Events[indexPath.row].UserDisplayName
        
        let avatarImageURL = URL(string: Events[indexPath.row].UserProfileURL)
        cell.imgUserAvatar.kf.setImage(with: avatarImageURL)
        
        cell.lblEventTitle.text = Events[indexPath.row].Title
        
        //cell.lblDescription.text = Events[indexPath.row]["Descrption"].stringValue
        
        cell.lblLocation.text = Events[indexPath.row].Location
        
        let imageURL = URL(string: Events[indexPath.row].EventImageUrl)
        cell.imgEvent.kf.setImage(with: imageURL)
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as! EventViewController
        
        vc.event = Events[indexPath.row]
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
   
    
    
}


