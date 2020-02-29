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
    
    let CommentedBy:User
    let CommentText:String
    
}
