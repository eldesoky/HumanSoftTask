//
//  AlbumCVC.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class AlbumCVC: UICollectionViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel = AlbumViewModel()
    var album: Album?
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = album?.title
        setupCollection()
        setupSearch()
        bindLoading()
        bindError()
        cellForItem()
        didSelectItem()
    }
    
    private func setupCollection(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let totalSpace = flowLayout.minimumInteritemSpacing
        let size = Int((collectionView.bounds.width - totalSpace) / 3)
        flowLayout.itemSize = CGSize(width: size, height: size)
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 44)
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(UINib(nibName: "AlbumItemCell", bundle: nil), forCellWithReuseIdentifier: "AlbumItemCell")
        collectionView.dataSource = nil
        collectionView.delegate = nil
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
    
    func cellForItem(){
         viewModel
             .filterdAlbumItems
             .bind(
                 to: collectionView
                     .rx
                     .items(
                         cellIdentifier: "AlbumItemCell",
                         cellType: AlbumItemCell.self)
             ) { row, data, cell in
                cell.config(data.thumbnailUrl)
         }.disposed(by: disposeBag)
        viewModel.getAlbumItems(album?.id ?? 0)
     }
     
     func didSelectItem(){
         collectionView
             .rx
             .itemSelected
             .subscribe(onNext:{ indexPath in
                let albumItem = self.viewModel.filterdAlbumItems.value[indexPath.row]
                self.previewImage(albumItem)
             }).disposed(by: disposeBag)
     }
    
    func previewImage(_ albumItem:AlbumItem) {
        let photoPreviewCoordinator = PhotoPreviewCoordinator(presenter: self.navigationController!, albumItem: albumItem)
        photoPreviewCoordinator.start()
    }
    
    func setupSearch() {
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        self.collectionView.addSubview(searchController.searchBar)
    }


}

extension AlbumCVC: UISearchResultsUpdating {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let items = viewModel.albumItems.value
        let searchText = searchController.searchBar.text ?? ""
        let searchData = searchText.isEmpty ? items : items.filter{ $0.title.range(of: searchText, options: .caseInsensitive) != nil }
        viewModel.filterdAlbumItems.accept(searchData)
    }
}
