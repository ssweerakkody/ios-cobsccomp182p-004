//
//  Routes.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/21/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit

class Routes{
    
    static func redirectToFeed(presentingVC: UIViewController){
        
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventNavigation") as! UITabBarController
        
        tabVC.selectedIndex = 1
        
        presentingVC.present(tabVC, animated: true, completion: nil)
        presentingVC.loadView()
        presentingVC.view.setNeedsLayout()
        
    }
    
    static func redirectToGuest(presentingVC: UIViewController){
        
        let vc = UIStoryboard(name: "Guest", bundle: nil).instantiateViewController(withIdentifier: "GuestNavigation")
        presentingVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func viewEvent(selectedEvent : Event ,selectedEventID:String,presentingTVC: UITableViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as! EventViewController
        
        vc.selectedEvent = selectedEvent
        vc.selectedEventID = selectedEventID
        
        presentingTVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func editEvent(selectedEvent : Event ,selectedEventID:String,presentingTVC: UITableViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostEventView") as! PostEventViewController
        
        vc.selectedEvent = selectedEvent
        vc.selectedEventID = selectedEventID
        
        presentingTVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}

