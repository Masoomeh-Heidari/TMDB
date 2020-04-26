//
//  MovieDetailCoordinator.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/6/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import RxSwift



class MovieDetailCoordinator:BaseCoordinator<Void> {
    
    let rootViewController: UIViewController
    let viewModel:MovieDetailViewModel
    
    init(rootViewController: UIViewController,viewModel: MovieDetailViewModel) {
        self.rootViewController = rootViewController
        self.viewModel = viewModel
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = MovieDetailViewController.initFromStoryboard(name: "Main")
        viewController.viewModel = self.viewModel
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        
        return Observable.never()
        
    }
    
}
