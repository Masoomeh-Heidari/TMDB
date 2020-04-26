//
//  AppCoordinator.swift
//  TMDB
//
//  Created by Fariba Heidari on 10/3/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = PopularMoviesViewController.initFromStoryboard(name: "Main")
        let viewModel = PopularMoviesViewModel()
        
        viewController.viewModel = viewModel
        
        let coordinator = PopularMoviesCoordinator.init(rootViewController: viewController,viewModel: viewModel)
        
        self.coordinate(to: coordinator).subscribe().disposed(by: self.disposeBag)
        
        //Add Filter button to navigationbar
        navigationController = UINavigationController(rootViewController: viewController)
     
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
}
