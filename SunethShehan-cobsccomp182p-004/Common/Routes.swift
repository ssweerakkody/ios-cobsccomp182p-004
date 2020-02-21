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
    
}

