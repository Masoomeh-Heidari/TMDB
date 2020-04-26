//
//  PopularMovieSectionController.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/5/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import Foundation
import IGListKit


class PopularMovieSectionController: ListSectionController {
    
    var object: MovieModel?
    var delegate: PopularMovieSectionSelectItemDelegate?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top:0, left: 0, bottom: 10, right: 0)
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
      guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: 140.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: MovieCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! MovieCollectionViewCell
        cell.setCell(model: object!)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? MovieModel
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.getSelecMovietSectionController(self)
    }
}


protocol PopularMovieSectionSelectItemDelegate {
    func getSelecMovietSectionController(_ selectedSectionController:ListSectionController)
}
