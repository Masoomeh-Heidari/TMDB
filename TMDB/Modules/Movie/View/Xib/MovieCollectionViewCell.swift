//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/5/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txTitle: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        self.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
    }
    
    func setCell(model: MovieModel){
        
        self.txTitle.text = model.original_title
        self.releaseDateLabel.text = "Date: "+(model.release_date ?? "unkown")
        if let path = model.backdrop_path, let url = Utility.createURLForImage(path: path) {
            
            imageView.sd_setImage(with: url , placeholderImage: UIImage(named: "placeholder.png"))
            
        }
    }
    
}
