//
//  SplashVC.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel = SplashViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        bindLoading()
        bindError()
        bindUser()
    }
    
    private func bindLoading() {
        viewModel
            .loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
    }
    
    private func bindError() {
        viewModel
            .error
            .bind(to: self.rx.error)
            .disposed(by: disposeBag)
        
    }
    
    private func bindUser() {
        viewModel
            .user
            .bind { user in
                if !UserUtil.isActive() {
                    UserUtil.save(user)
                }
                self.goToProfile()
        }.disposed(by: disposeBag)
        
        viewModel.getUser()
    }
    
    private func goToProfile() {
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
    }

}
