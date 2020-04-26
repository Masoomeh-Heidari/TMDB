//
//  PopularMoviesCoordinator.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/4/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import RxSwift


class PopularMoviesCoordinator:BaseCoordinator<Void> {
    
    
    private let rootViewController: UIViewController
    
    private let viewModel : PopularMoviesViewModel!
    
    init(rootViewController: UIViewController, viewModel : PopularMoviesViewModel) {
        
        self.rootViewController = rootViewController
        self.viewModel = viewModel
    }
    
    override func start() -> Observable<Void> {
        
        viewModel.selectedMovie.asObservable().subscribe({ value in
            
            let viewModel = MovieDetailViewModel()
            viewModel.selectedMovie.onNext(value.element!)
            
            let coordinator = MovieDetailCoordinator(rootViewController: self.rootViewController, viewModel: viewModel)
            
            self.coordinate(to: coordinator).subscribe().disposed(by: self.disposeBag)
            
        }).disposed(by: self.disposeBag)
        
        return Observable.never()
        
    }
}
