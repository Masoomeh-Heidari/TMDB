//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/6/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailViewModel: BaseViewModel {
    let selectedMovie = ReplaySubject<MovieModel>.create(bufferSize: 1)
    
    
}
