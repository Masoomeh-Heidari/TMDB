//
//  MovieModel.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/4/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieModel:NSObject, Mappable {    
    var poster_path :String?
    var adult :Bool?
    var overview :String?
    var release_date :String?
    var genre_ids :[Int]?
    var _id = 0
    var original_title :String?
    var backdrop_path :String?
    var popularity :Float?
    var vote_count :Int?
    var video :Bool?
    var vote_average :Float?
    
    
    override init() {
     }
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        
        poster_path <- map["poster_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        release_date <- map["release_date"]
        genre_ids <- map["genre_ids"]
        _id <- map["id"]
        original_title <- map["original_title"]
        backdrop_path <- map["backdrop_path"]
        popularity <- map["popularity"]
        vote_count <- map["vote_count"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        
    }
    
}
