//
//  UIActivityIndicatorView+Rx.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {

    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { vc, active in
            if active {
                vc.startLoading()
            } else {
                vc.stopLoading()
            }
        }
    }
    
    
    public var error: Binder<Error> {
        return Binder(self.base, binding: { (vc, error) in
            
            let alert = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: UIAlertController.Style.alert)
            
            let okAaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(okAaction)
            vc.present(alert, animated: true, completion: nil)
        })
    }

}
