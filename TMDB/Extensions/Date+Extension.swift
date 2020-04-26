//
//  Date+Extension.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/6/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation

extension Date {
    
    var year: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(.year, from: self)
        }
    }
    
}
