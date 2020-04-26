//
//  RequestManager.swift
//  TMDB
//
//  Created by Fariba Heidari on 10/3/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//


import Foundation
import Alamofire

typealias requestManagerCallBackResult = (Any?,Error?) -> Void

protocol RequestManagerProtocol {
    func callAPI(requestConvertible: URLRequestConvertible, callback: @escaping requestManagerCallBackResult)
}

class RequestManager: RequestManagerProtocol {
    

    func callAPI(requestConvertible: URLRequestConvertible, callback: @escaping requestManagerCallBackResult) {
        
        AF.request(requestConvertible).validate(statusCode: 200...400).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
                
            case .success(_):
                
                do {
                    
                    let data = try response.result.get()
                    
                    callback(data,nil)
                    
                } catch {
                    
                    callback(nil,self.typeError(statusCode: statusCode))
                    
                }
                
            case .failure(_):
                
                callback(nil,self.typeError(statusCode: statusCode))
                
            }
        }
    }
}

extension RequestManager {
    
    fileprivate func typeError(statusCode:Int?) -> ErrorService {
        switch statusCode ?? 0 {
            case 401: return .error401
            case 403: return .error404
            default: return .error500
        }
    }
}



public enum ErrorService : Error {
    case error401
    case error404
    case error500
}

extension ErrorService: LocalizedError {
    
    public var errorDescription: String?{
        
        switch self {
            case .error401: return "401"
            case .error404: return "404"
            case .error500: return "Internal server error, code 500!"
        }
    }
}

public class APIError: LocalizedError {
    
    var status_code = 0
    
    required convenience public init?(status_code: Int) {
        self.init()
        self.status_code = status_code
    }
    
    public var errorDescription: String?
    {
        switch status_code {
        case 401:
            return NSLocalizedString("error_401", comment: "error")
        case 404:
            return NSLocalizedString("error_404", comment: "error")
        default:
            return NSLocalizedString("error_text", comment: "error")
        }
    }
}

