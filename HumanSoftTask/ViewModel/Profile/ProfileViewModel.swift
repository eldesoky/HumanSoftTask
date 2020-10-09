//
//  ProfileViewModel.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

final class ProfileViewModel {
    
    let loading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Swift.Error>()
    let profileSections = BehaviorRelay<[SectionModel<String, String>]>(value: [])
    let albums = BehaviorRelay<[Album]>(value: [])

    private let disposeBag = DisposeBag()
    
    func getAlbums() {
        
        guard let user = UserUtil.load() else { return }
        
        self.loading.accept(true)
        ApiClient
            .getAlbums(userId: user.id)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { albums in
                self.profileSections.accept([self.userSection(user) , self.albumsSection(albums)])
                self.albums.accept(albums)
                self.loading.accept(false)
            }, onError: { errorData in
                self.error.onNext(errorData)
                self.loading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func userSection(_ user:User) -> SectionModel<String, String> {
        let address = user.address.fullAddress
        let userSection = SectionModel(model: user.name , items: [address])
        return userSection
    }
    
    private func albumsSection(_ albums:[Album]) -> SectionModel<String, String> {
        let albumsTitles = albums.map{String($0.title)}
        let albumsSection = SectionModel(model: "My Albums" , items: albumsTitles)
        return albumsSection
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, String>> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
            
            configureCell: { (dataSource , tableView, indexPath, item) -> UITableViewCell in
                let cell: UITableViewCell = UITableViewCell()
                cell.selectionStyle = .none
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
                cell.textLabel?.text = item
                cell.textLabel?.numberOfLines = 0
                return cell
        })
        
        return dataSource
    }

}
