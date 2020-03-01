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
    
    static func redirectToLogin(presentingVC: UIViewController){
        
        let vc = UIStoryboard(name: "UserAuthentication", bundle: nil).instantiateViewController(withIdentifier: "RootUserNavigation")
        presentingVC.present(vc, animated: true, completion: nil)
        
    }
    
    
    static func viewEvent(selectedEvent : Event ,selectedEventID:String,presentingTVC: UITableViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as! EventViewController
        
        vc.selectedEvent = selectedEvent
        vc.selectedEventID = selectedEventID
        
        presentingTVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func authourViewEvent(selectedEvent : Event ,selectedEventID:String,presentingVC: UIViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsViewController") as! EventViewController
        
        vc.selectedEvent = selectedEvent
        vc.selectedEventID = selectedEventID
        
        presentingVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    static func editEvent(selectedEvent : Event ,selectedEventID:String,presentingTVC: UITableViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostEventView") as! PostEventViewController
        
        vc.selectedEvent = selectedEvent
        vc.selectedEventID = selectedEventID
        
        presentingTVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func showUserProfile(userID:String,presentingVC: UIViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileView") as! ProfileViewController
        
        vc.userID = userID
        
        presentingVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func showComments(selectedEventID:String,presentingVC: UIViewController){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsStoryboard") as! CommentsTableViewController
        
        vc.selectedEventID = selectedEventID
        
        presentingVC.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}

