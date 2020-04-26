//
//  EmptyView.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/5/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      loadNib()
    }
    
    func loadNib() {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: "EmptyView", bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      view.frame = bounds
      view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      view.translatesAutoresizingMaskIntoConstraints = true
    }

}
