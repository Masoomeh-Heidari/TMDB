//
//  BaseResponse.swift
//  Zabanshenas
//
//  Created by Fariba Heidari on 10/4/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//

import ObjectMapper
import Foundation

class BaseResponse<T:Mappable>: Mappable {
    var page : Int?
    var total_results : Int?
    var total_pages :Int?
    var results :[T]?
    
    required init(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        page <- map["page"]
        total_results <- map["total_results"]
        total_pages <- map["total_pages"]
        results <- map["results"]
    }
    
}

