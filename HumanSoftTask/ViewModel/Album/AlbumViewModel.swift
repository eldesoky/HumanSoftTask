//
//  AlbumViewModel.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class AlbumViewModel {
    
    let loading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Swift.Error>()
    let albumItems = BehaviorRelay<[AlbumItem]>(value: [])
    let filterdAlbumItems = BehaviorRelay<[AlbumItem]>(value: [])
    
    private let disposeBag = DisposeBag()

    func getAlbumItems(_ albumId:Int) {
        
        self.loading.accept(true)
        ApiClient
            .getAlbumItems(albumId: albumId)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { albumItems in
                self.albumItems.accept(albumItems)
                self.filterdAlbumItems.accept(albumItems)
                self.loading.accept(false)
            }, onError: { errorData in
                self.error.onNext(errorData)
                self.loading.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
