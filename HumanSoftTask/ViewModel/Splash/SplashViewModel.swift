//
//  SplashViewModel.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class SplashViewModel {
    
    let loading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Swift.Error>()
    let user = PublishSubject<User>()
    
    private let disposeBag = DisposeBag()
    
    func getUser() {
        guard let user = UserUtil.load() , UserUtil.isActive() else { return self.getUserRequest() }
        self.user.onNext(user)
    }

    private func getUserRequest() {
        self.loading.accept(true)
        ApiClient
            .getUsers()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { users in
                if let user = users.first {
                    self.user.onNext(user)
                }
                self.loading.accept(false)
            }, onError: { errorData in
                self.error.onNext(errorData)
                self.loading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
}
