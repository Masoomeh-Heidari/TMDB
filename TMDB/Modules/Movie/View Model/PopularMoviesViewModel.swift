//
//  PopularMoviesViewModel.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/4/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import RxSwift

class  PopularMoviesViewModel :BaseViewModel{
    
    let selectedMovie = ReplaySubject<MovieModel>.create(bufferSize: 1)
    let datePickerDelegate = ReplaySubject<DatePickerDelegate>.create(bufferSize: 1)

    let serviceManager:MovieService!
    
    init(serviceManager : MovieService =  MovieService()) {
        self.serviceManager = serviceManager
    }
    
    func getPopularMovieList(page:Int) -> Observable<Any?>  {
        return Observable.create { observer -> Disposable in
            self.serviceManager.getPopularMovieList(page : page,callBack: { (response, error) in
                if let _ = error {
                    observer.onError(error!)
                }else if let data = response {
                    observer.on(.next(data))
                    observer.on(.completed)
                }
            })
            return Disposables.create()
        }
    }
    
}
