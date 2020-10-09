//
//  ProfileTVC.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileTVC: UITableViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel = ProfileViewModel()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "Profile"
        bindLoading()
        bindError()
        setupRXTableView()
        dataSource()
        didSelectRow()
    }
    
    private func setupRXTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.tableFooterView = UIView()
        // add this line you can provide the cell size from delegate method
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
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
     
    private func dataSource() {
        viewModel
            .profileSections
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource()))
            .disposed(by: disposeBag)
        viewModel.getAlbums()
    }
    
    func didSelectRow(){
        tableView
            .rx
            .itemSelected
            .subscribe(onNext:{ indexPath in
                if indexPath.section == 1 {
                    self.goToAlbum(self.viewModel.albums.value[indexPath.row])
                }
            }).disposed(by: disposeBag)
    }
        
    
     func goToAlbum(_ album: Album) {
        let albumCoordinator = AlbumCoordinator(presenter: self.navigationController!, album: album)
        albumCoordinator.start()
    }

}

extension ProfileTVC {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 40)
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.bounds.width - 32, height: 40))
        titleLabel.text = viewModel.profileSections.value[section].model
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
