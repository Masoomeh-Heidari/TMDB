//
//  SignupRouter.swift
//  TMDB
//
//  Created by Fariba Heidari on 10/4/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//

import Foundation
import Alamofire

enum MovieServiceRouter  {
    
    case popular(page: String)

}

extension MovieServiceRouter :Router {
    
    var path: String {
        switch self {
            case .popular:
                return "/popular"
        }
    }
    
    var method: HTTPMethod? {
        switch self {
            case .popular:
                return .get
        }
    }
    
    var params: Parameters? {
         switch self {
             case .popular(let page):
                return ["api_key":API.API_KEY ,"page": page]
         }
     }
}
