//
//  ErrorModel.swift
//  TMDB
//
//  Created by Fariba Heidari on 10/4/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//

import Foundation
import ObjectMapper


class ErrorModel: Mappable {
    
    var status_code :String?
    var status_message :String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status_code <- map["status_code"]
        status_message <- map["status_message"]
    }
    
}
