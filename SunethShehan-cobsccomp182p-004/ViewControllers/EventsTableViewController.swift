//
//  EventsTableViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/9/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Firebase

final class EventsTableViewController: UITableViewController {
 
    
    private var Events = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ref = Database.database().reference().child("Events")
        ref.observe(.value, with: { snapshot in
           
            self.Events.removeAll()
            
            let dict = snapshot.value as? [String: AnyObject]
            let json = JSON(dict as Any)
            
            for object in json{
             
                self.Events.append(object.1)
                print(object.1)
                //print(self.items)
            }
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Events.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",for: indexPath) as! EventsTableViewCell
        
        
        cell.lblEventTitle.text = Events[indexPath.row]["Title"].stringValue
        
        cell.lblDescription.text = Events[indexPath.row]["Descrption"].stringValue
        
        cell.lblLocation.text = Events[indexPath.row]["Location"].stringValue
        
        let imageURL = URL(string: Events[indexPath.row]["EventImageUrl"].stringValue)
        cell.imgEvent.kf.setImage(with: imageURL)

        
        return cell
    }
    
    
    
}
