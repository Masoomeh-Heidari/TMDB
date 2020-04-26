//
//  String+Extenstion.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/6/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation


extension String {
    
    var date :Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
            let date = dateFormatter.date(from: self)
            return date
        }
    }
    
}
