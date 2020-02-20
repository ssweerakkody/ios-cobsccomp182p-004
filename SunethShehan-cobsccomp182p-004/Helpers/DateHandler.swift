//
//  DateHandler.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/20/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit

class DateHandler{
    
    static let dateFormatter = DateFormatter()
    
    static func castDateToString(date : Date)->String{
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: date)
    
        return strDate
    }
    
    static func castStringToDate(date : String)->Date{
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let eventDate = dateFormatter.date(from: date)
        
        return eventDate!

        
    }
    
}
