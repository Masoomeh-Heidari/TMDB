//
//  Utility.swift
//  Zabanshenas
//
//  Created by Fariba Heidari on 10/4/1398 AP.
//  Copyright © 1398 AP Fariba. All rights reserved.
//

import Foundation
import PKHUD

class Utility {
    
    
    //MARK:- Show/Hide HUD and Popup dialogs
    class func showHUDMessage(success: Bool, title: String, message: String, completion: ((Bool) -> Void)? = nil) {
        (success) ? showSuccessHUD(title, message, completion) : showFailureHUD(title, message, completion)
    }
    
    class func showHUDLoading(title: String, message: String, completion: ((Bool) -> Void)? = nil) {
        self.showHUDLoading(title: title, message: message, on: nil, completion: completion)
    }
    
    class func showHUDLoading(title: String, message: String, on view: UIView?, completion: ((Bool) -> Void)? = nil) {
        DispatchQueue.main.async {
            HUD.flash(.labeledProgress(title: title, subtitle: message), onView:view, delay: 60.0) { (finished) in
                self.hideHUD()
                completion?(finished)
            }
        }
    }
    
    class func showActionMessage(title: String, message: String, actions: [MMPopupItem]) {
        DispatchQueue.main.async {
            let hud = MMAlertView(title: title, detail: message, items: actions)
            hud?.show()
        }
    }
    
    class func hideHUD() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
    
    fileprivate class func showSuccessHUD(_ title: String, _ message: String, _ completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async {
            HUD.flash(.labeledSuccess(title: title, subtitle: message), delay: 2.0) { (finished) in
                HUD.hide()
                completion?(finished)
            }
        }
    }
    
    fileprivate class func showFailureHUD(_ title: String, _ message: String, _ completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async {
            HUD.flash(.labeledError(title: title, subtitle: message), delay: 2.0) { (finished) in
                HUD.hide()
                completion?(finished)
            }
        }
    }
    
    //MARK:- Popup actions
    class func actionMessageOK(_ completion: (() -> Void)? = nil) -> MMPopupItem {
        return MMItemMake("تایید", .highlight, { (_) in
            completion?()
        })
    }
    
    class func actionMessageOK_normal(_ completion: (() -> Void)? = nil) -> MMPopupItem {
        return MMItemMake("تایید", .normal, { (_) in
            completion?()
        })
    }
    
    class func actionMessageCancel(_ completion: (() -> Void)? = nil) -> MMPopupItem {
        return MMItemMake("بازگشت", .highlight, { (_) in
            completion?()
        })
    }
    
    class func actionMessageRetry(_ completion: (() -> Void)? = nil) -> MMPopupItem {
        return MMItemMake("تلاش مجدد", .highlight, { (_) in
            completion?()
        })
    }
    
    
    class func createURLForImage(path: String)-> URL? {
        let urlString = API.IMAGE_BASE_URL.appending(path)
        return URL(string: urlString)
    }
    
}

