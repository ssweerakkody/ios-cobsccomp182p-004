//
//  Comment.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/29/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import Firebase
import CodableFirebase

struct Comment : Codable {
    
    var CommentID:String
    var CommentedBy:String
    var CommentText:String
    var CommnetedUserImage:String
    
    init(CommentID:String,CommentedBy:String,CommentText:String,CommnetedUserImage:String) {
        
        self.CommentID = CommentID
        self.CommentedBy = CommentedBy
        self.CommentText = CommentText
        self.CommnetedUserImage = CommnetedUserImage
       
    }
    
}

