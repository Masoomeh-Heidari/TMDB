//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/6/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class MovieDetailViewController: UIViewController ,StoryboardInitializable{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var viewModel: MovieDetailViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.selectedMovie.asObserver().subscribe(onNext: { (model) in
           
            if let path = model.backdrop_path, let url = Utility.createURLForImage(path: path) {
                       
                self.imageView.sd_setImage(with: url , placeholderImage: UIImage(named: "placeholder.png"))
                       
            }
            
            self.titleLabel.text = model.original_title
            
        }).disposed(by: self.disposeBag)

    }
    

}
