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
       
        addStylesToTableView()
        setupView()

    }
    
    @IBAction func GoToLogin(_ sender: Any) {
        
        Routes.redirectToLogin(presentingVC: self)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Events.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 465
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestEventCell",for: indexPath) as! EventsTableViewCell
        
        let event = Events[indexPath.row]
        
        // cell.lblDocID.text = EventIDs[indexPath.row]
        
        
        cell.lblEventDate.text = event.EventDate
        
        cell.lblCreatedBy.text =  event.UserDisplayName
        
        let avatarImageURL = URL(string: event.UserProfileURL)
        cell.imgUserAvatar.kf.setImage(with: avatarImageURL)
        
        cell.lblEventTitle.text = event.Title
        
        //cell.lblDescription.text = Events[indexPath.row]["Descrption"].stringValue
        cell.lblAttendeesCount.text = String(event.AttendeesCount)
        
        cell.lblLocation.text = event.Location
        
        let imageURL = URL(string: event.EventImageUrl)
        cell.imgEvent.kf.setImage(with: imageURL)
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        Routes.viewEvent(selectedEvent: Events[indexPath.row], selectedEventID: EventIDs[indexPath.row], presentingTVC: self)
        
    }
    
    func setupView(){
        
        if(!Reach.isConnectedToInternet(viewController: self))
        {
            return
        }
        
        FirestoreClient.getAllEvents(completion: {events , eventIDs in
            
            self.Events.removeAll()
            self.EventIDs.removeAll()
            
            self.Events = events
            self.EventIDs = eventIDs
        })
    }
    
    func addStylesToTableView(){
        
        self.setTableViewBackgroundImage()
        
    }
    
}


