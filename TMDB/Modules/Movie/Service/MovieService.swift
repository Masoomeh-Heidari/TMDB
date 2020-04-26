//
//  SignupService.swift
//  TMDB
//
//  Created by Fariba Heidari on 10/4/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//

import Foundation
import ObjectMapper

typealias serviceCallBack = ((_ response:[Mappable]?,_ error :Error?)-> Void)


protocol MovieServiceProtocol {
    func getPopularMovieList(page: Int, callBack :@escaping serviceCallBack)

}


class MovieService: MovieServiceProtocol {
    
    let requestManager:RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func getPopularMovieList(page: Int, callBack: @escaping serviceCallBack) {
        self.requestManager.callAPI(requestConvertible: MovieServiceRouter.popular(page: String(page))) { (response,error) in
            if let dict = response as? [String : Any], let data = Mapper<BaseResponse<MovieModel>>().map(JSON: dict) {
                callBack(data.results,nil)
            }else {
                callBack(nil,error)
            }
        }
    }
}
