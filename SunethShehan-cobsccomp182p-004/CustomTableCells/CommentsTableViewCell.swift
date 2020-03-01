//
//  CommentsTableViewCell.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/29/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit


class CommentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgUser: UIImageView!
    
    
    @IBOutlet weak var lblCommentText: UILabel!
    
    @IBOutlet weak var lblCommetedBy: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
         addStylesToCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addStylesToCell(){
        imgUser.toRoundedImage()
    }

}
