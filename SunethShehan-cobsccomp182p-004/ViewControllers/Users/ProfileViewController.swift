//
//  ProfileViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/23/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController :  UIViewController {
    
    
    @IBOutlet weak var lblFName: UILabel!
    
    @IBOutlet weak var lblLName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblDisplayName: UILabel!
    
    @IBOutlet weak var lblMobileNo: UILabel!
    
    @IBOutlet weak var lblFBProfileUrl: UILabel!
    
    
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    var userID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addStylesToView()
        
        FirestoreClient.getUserProfile(uID: userID!) { (user) in
            
            self.lblFName.text =  user.FirstName
            self.lblLName.text =  user.LastName
            self.lblEmail.text =  user.Email
            self.lblDisplayName.text =  user.DisplayName
            self.lblMobileNo.text =  user.MobileNo
            self.lblFBProfileUrl.text =  user.FBProfileUrl
            
            
            let imageURL = URL(string: user.ProfileImageUrl)
            self.imgUserProfile.kf.setImage(with: imageURL)
        
            
        }
        
        
    }
    
    func addStylesToView(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backimage.jpg")!)
        
        imgUserProfile.toRoundedImage()
        imgUserProfile.addWhiteBorder()
        
        
    }
}
