//
//  Alerts.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/21/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit

class Alerts{
    
    static func showAlert(title: String?, message: String, presentingVC: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        presentingVC.present(alertController, animated: true, completion: nil)
    }
    
    static func showLoadingAlert(message: String, presentingVC: UIViewController)->UIAlertController {
        
        let alert : UIAlertController
        
        alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        presentingVC.present(alert, animated: true, completion: nil)
        
        return alert
        
    }
    
    
}
