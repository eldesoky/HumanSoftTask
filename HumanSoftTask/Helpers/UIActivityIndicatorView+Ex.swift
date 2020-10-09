//
//  UIActivityIndicatorView+Ex.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func startLoading()  {
        let activity = UIActivityIndicatorView()
        activity.frame =  CGRect(x: 0.0, y: 0.0, width: 40.0,height: 40.0)
        activity.center = self.view.center
        activity.tag = 112233
        self.view.addSubview(activity)
        activity.bringSubviewToFront(self.view)
        activity.startAnimating()
    }
    
    func stopLoading()  {
        self.view.viewWithTag(112233)?.removeFromSuperview()
    }
}

